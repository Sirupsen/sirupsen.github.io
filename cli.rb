require 'thor'
require 'uri'
require 'json'
require 'net/http'
require 'pp'
require 'pathname'
require 'byebug'

# CLI for managing blog
class Sirupsen < Thor
  desc 'images', 'Localize images'
  def images
    i = 0
    Dir['content/**/*.md'].each do |path|
      body = File.read(path)
      paths = body.scan(/\!\[.*\]\((.+)\)/).flatten
      external_images = paths.select { |path|
        path.start_with?("https://") && path =~ /\.(jpg|jpeg|png|gif)$/i
      }

      external_images.each do |image_path|
        image_name = Pathname.new(image_path).basename.to_s
        new_path = "./static/static/images/#{image_name}"

        unless File.exist?(new_path)
          puts "Downloading #{image_path}.."
          system("curl #{image_path} -o #{new_path}")
        end

        url_path = "/static/images/#{image_name}"
        body.sub!(image_path, url_path)
      end

      File.open(path, 'w') { |f| f.write(body) }
    end
  end

  desc "buttondown", "Download buttondown emails"
  def buttondown(name = nil)
    json = `curl -s -H "Authorization: Token #{ENV['BUTTONDOWN_TOKEN']}" https:///api.buttondown.email/v1/emails`
    result = JSON.parse(json)
    emails = result['results']
    emails.each do |email|
      filename = "./content/napkin/#{email["slug"].gsub("napkin-", "")}.md"
      next if File.exist?(filename)
      puts 'yes'
      File.open(filename, 'w') do |f|
        f.write("---\n")
        f.write("date: #{email["publish_date"]}\n")
        f.write("title: #{email["subject"].inspect}\n")
        f.write("---\n\n")
        f.write(email["body"])
      end
    end
  end

  desc "goodreads", "Goodreads review sync"
  def goodreads(name = nil)
    require 'goodreads'
    client = Goodreads.new(api_key: ENV["GOODREADS_KEY"], spi_secret: ENV["GOODREADS_SECRET"])
    1.upto(100) do |page|
      puts "Page: #{page}"
      reviews = client.reviews(id: 38623347, per_page: 50, page: page)
      return if reviews.empty?
      reviews.each do |review|
        # split is so that "where good ideas come from: the natural history of
        # invention" doesn't have the last part in the slug.
        book_title_short = review.book.title.split(":")[0]
          .downcase.gsub(/ /, "-")
          .gsub(/[^\w\-]/, "")

        icon = case review.rating.to_i
               when 5
                 "🥇"
               when 4
                 "🥈"
               when 3
                 "🥉"
               when 2
                 "🤷"
               when 1
                 "😞"
               else
                 "❓"
               end

        rating = review.rating.to_i > 0 ? review.rating : "-1"

        body = review.body
        body.gsub!(/&gt\;(.+?)\<br \/><br \/>/, "<blockquote>\\1</blockquote>")

        # byebug if review.book.title =~ /grit/i

        filename = "./content/books/#{book_title_short}.html"
        File.open(filename, 'w+') do |f|
          f.write("---\n")
          f.write("date: \"#{Time.parse(review.read_at || review.date_added)}\"\n")
          f.write("title: \"#{review.book.title}\"\n")
          f.write("book_author: \"#{review.book.authors.author.name.gsub("\"", "'")}\"\n")
          f.write("book_rating: \"#{rating}\"\n")
          f.write("book_rating_icon: \"#{icon}\"\n")
          f.write("book_publication_year: \"#{review.book.publication_year}\"\n")
          f.write("book_goodreads_link: \"#{review.book.link}\"\n")
          f.write("---\n\n<p>")
          f.write(body.strip)
          f.write("</p>")
        end
      end
    end
  end
end

Sirupsen.start(ARGV)
