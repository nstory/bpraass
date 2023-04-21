require "csv"

def parse_id(line)
    if /^[^a-z0-9]{0,3}([a-z0-9]{3,}-[a-z0-9]{3,})/i =~ line
      $1.gsub(/[OQo]/, "0")
    else
      nil
    end
end

puts ["id", "text"].to_csv

Dir.glob("output/*.txt").each do |txt_file|
  current_id = nil
  text = ""
  IO.read(txt_file).each_line do |line|
    new_id = parse_id(line)
    if new_id
      puts [current_id, text].to_csv if current_id
      current_id = new_id
      text = ""
    end
    text += line.gsub(/\s+/, " ")
  end
  puts [current_id, text].to_csv
end
