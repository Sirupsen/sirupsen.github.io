[
  ["12kb", 12_000],
  ["14kb", 14_000],
  ["25kb", 25_000],
  ["50kb", 50_000],
  ["100kb", 100_000],
  ["200kb", 200_000],
  ["400kb", 400_000],
].each do |(name, bytes)|
  File.open("#{name}.html", 'w') do |f|
    bytes.times { f.write 'b' }
  end
end
