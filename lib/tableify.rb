require "csv"

# lol these parsing scripts always turn into spaghetti

def parse_date(str)
  if %r{^\s+(\d{1,2}/\d{1,2}/\d{2,4})} =~ str
    [$1, $']
  else
    nil
  end
end

def parse_id(line)
    if %r{^[^a-z0-9]{0,10}([a-z0-9]{3,}-[a-z0-9]{3,})}i =~ line
      # (\s+\d{1,2}/\d{1,2}/\d{2,4})?
      rest = $'
      id = $1.gsub(/[OQo]/, "0")
      created, rest = parse_date(rest)
      closed, rest = parse_date(rest)
      {id: id, created: created, closed: closed}
    else
      nil
    end
end

def run
  puts ["id", "created", "closed", "text"].to_csv

  txt_files = ENV.fetch("OUTPUT_TXT_FILES").split(/\s+/)
  txt_files.each do |txt_file|
    current_id = nil
    created = nil
    closed = nil
    text = ""
    IO.read(txt_file).each_line do |line|
      parsed = parse_id(line)
      if parsed
        puts [current_id, created, closed, text].to_csv if current_id
        current_id, created, closed = parsed[:id], parsed[:created], parsed[:closed]
        text = ""
      end
      text += line.gsub(/\s+/, " ")
    end
    puts [current_id, created, closed, text].to_csv
  end
end

if $PROGRAM_NAME == __FILE__
  run
end
