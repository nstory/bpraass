class Csvify
  def initialize(input_file: nil, output_file: nil, text: nil, requests_csv: nil)
    @input_file = input_file
    @output_file = output_file
    @text = text
    @requests_csv = requests_csv
  end

  def call
    output = [
      ["Reference No", "Create Date", "Close Date", "Department", "Description"],
      *rows
    ].map(&:to_csv).join("")
    IO.write(@output_file, output, encoding: "UTF-8")
  end

  def rows
    chunks_of_text.map do |chunk|
      rowify(chunk)
    end
  end

  def chunks_of_text
    # each chunk starts with a reference number followed by a date e.g. R001153-040323
    offsets = []
    text.scan(/\b[A-Z]\d{6}-\d{6}\b\s+\d+\/\d+/) { offsets << $~.begin(0) }

    offsets.each_with_index.map do |offset, idx|
      # up to the next reference number (and special case if this is the last ref number)
      end_offset = idx+1 < offsets.count ? offsets[idx+1] - 1 : text.length - 1

      # or the end-of-page if that comes first
      end_offset = [end_offset, text.index("\f", offset)].min

      chunk = text[offset .. end_offset]
      clean_up_chunk(chunk)
    end
  end

  private
  def clean_up_chunk(chunk)
    chunk = chunk.sub(/page\s*\d+\s*of\s*\d+/i, "")
    chunk.strip
  end

  def rowify(chunk)
    # first 15 chars are reference number
    ref_no = chunk[0 ... 14]

    # followed by Create Date and (maybe) Close Date
    create_date, close_date, after_dates_index = parse_dates(chunk)

    # get the department name from the requests csv, and remove it from the description
    request = requests[ref_no]
    binding.pry unless chunk[after_dates_index .. -1]
    description = chunk[after_dates_index .. -1].strip.gsub(/\s+/, " ")
    description = description.sub(/\A#{request['Dept']} */, "") if request

    [ref_no, create_date, close_date, request ? request["Dept"] : "", description]
  end

  def parse_dates(chunk)
    txt = chunk[14 .. -1].strip
    if %r{\A(\d+/\d+/\d+)(\s+\d+/\d+/\d+)?} =~ txt
      [attempt_parse_date($1), attempt_parse_date($2), $~.end(0) + 15]
    else
      ["", "", 15]
    end
  end

  def attempt_parse_date(txt)
    return "" unless txt
    txt = txt.strip
    date = Date.strptime(txt, "%m/%d/%Y")
    date = Date.new(date.year+2000, date.month, date.day) if date.year < 2000 # lol
    date.to_s
  rescue Date::Error
    ""
  end

  def requests
    @requests ||= CSV.parse(IO.read(@requests_csv, encoding: "UTF-8"), headers: true).map do |row|
      [row["Reference No"], row]
    end.to_h
  end

  def text
    @text ||= `pdftotext -raw "#{@input_file}" -`
  end
end
