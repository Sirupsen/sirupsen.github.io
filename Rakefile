require 'rake'
require 'kramdown'
require 'byebug'

desc "Compile CSS files"
task :css do
  puts "Merging CSS"

  `rm static/css/style.css`
  `rm static/css/temp.css`

  %W{font-awesome syntax skeleton base layout}.each do |file|
    `cat ./static/css/#{file}.css >> ./static/css/temp.css`
  end

  # `mv ./static/css/temp.css ./static/css/style.css`
  `yuicompressor ./static/css/temp.css > ./static/css/style.css`

  puts 'CSS dumped to ./static/css/style.css'
end

desc "Compile Images"
task :img do
  post = "./_posts/2018-07-15-read.md"
  post_content = File.read(post)
  doc = Kramdown::Document.new(post_content)
  puts "Processing images for #{post}.."

  images = doc.root.children.select { |e| e.type == :p }
    .flat_map { |e| e.children }
    .select { |e| e.type == :img }

  images.each do |image|
    real_src = image.attr['src']

    src = real_src.dup
    src = File.expand_path(src) unless src.start_with?("http")

    name = File.basename(src)
    name += ".png" if File.extname(src).empty?

    tmp_target = "/tmp/sirupsen_com_#{name}"
    dest_target = "./static/images/#{name}"

    if src.start_with?("http")
      unless File.exists?(tmp_target)
        puts "Downloading #{src}.."
        `curl -L --silent #{src.inspect} -o #{tmp_target.inspect}`
      end
    elsif src[/static/]
      tmp_target = src # in static already
      dest_target = real_src
    else
      tmp_target = src
    end

    `convert -strip #{tmp_target.inspect} -resize 928x #{tmp_target.inspect}`
    `convert #{tmp_target.inspect} -resize x1000 #{dest_target}`

    image.attr["src"] = dest_target

    post_content.sub!(real_src, dest_target.sub("./static", "/static"))
  end

  File.open(post, "w") { |f| f.write(post_content) }
end

desc "Prepare Deploy Assets"
task :prepare do
  Rake::Task['css'].execute
  Rake::Task['img'].execute
end

task "Serve"
task :serve do
  Rake::Task['css'].execute

  `open http://localhost:4000`
  `jekyll --serve --no-pygments`
end
