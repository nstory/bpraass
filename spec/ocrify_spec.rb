describe Ocrify do
  [
    ["input/City_of_Boston_Public_Records_Requests_2017_Redacted.pdf", Date.new(2017, 1, 1), Date.new(2017, 12, 31)],
    ["input/2022AllRequests_Q2_Redacted.pdf", Date.new(2022, 4, 1), Date.new(2022, 6, 30)]
  ].each do |input_file, start_date, end_date|
    it "#start_date is #{start_date} for #{input_file}" do
      expect(Ocrify.new(input_file: input_file, output_file: "xxx").start_date).to eql(start_date)
    end

    it "#end_date is #{end_date} for #{input_file}" do
      expect(Ocrify.new(input_file: input_file, output_file: "xxx").end_date).to eql(end_date)
    end
  end
end
