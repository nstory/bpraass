class Ocrify
  def initialize(input_file:, output_file:)
    @input_file = input_file
    @output_file = output_file
  end

  def call
    # user words file contains hints to tesseract about words that appear in the doc
    Tempfile.create(["user_words", ".txt"]) do |tempfile|
      tempfile.write((reference_nos + dates).join("\n"))
      tempfile.flush
      # the default output-type pdf/a is corrupting text on skipped pages
      system("ocrmypdf", "--user-words", tempfile.path, "--output-type", "pdf", "--skip-text", @input_file, @output_file, exception: true)
    end
  end

  def start_date
    month = case File.basename(@input_file)
            when /q2/i
              4
            when /q3/i
              7
            when /q4/i
              10
            else
              1
            end
    Date.new(year, month, 1)
  end

  def end_date
    month, day = case File.basename(@input_file)
                 when /q1/i
                   [3, 31]
                 when /q2/i
                   [6, 30]
                 when /q3/i
                   [9, 30]
                 else
                   [12, 31]
                 end
    Date.new(year, month, day)
  end

  def reference_nos
    sd = start_date
    ed = end_date
    CSV.parse(IO.read(ENV.fetch("ALL_REQUESTS_CSV"), encoding: "UTF-8"), headers: true).select do |row|
      date = Date.strptime(row["Created"], "%m/%d/%Y")
      date >= sd && date <= ed
    end.map { |row| row["Reference No"] }
  end

  def dates
    (start_date .. end_date).map { |d| d.strftime("%m/%e/%Y").gsub(/^0| /, '') }
  end

  private
  def year
    raise "unable to find year in #{@input_file}" unless /20[12]\d/ =~ @input_file
    $&.to_i
  end
end
