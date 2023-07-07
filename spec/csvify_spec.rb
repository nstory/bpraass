describe Csvify do
  let(:text_file) { "2023q2p01_02.txt" }
  let(:csvify) { Csvify.new(text: IO.read("#{__dir__}/fixtures/files/#{text_file}", encoding: "UTF-8"), requests_csv: "#{__dir__}/fixtures/files/requests.csv") }

  it "chunks_of_text" do
    chunks = csvify.chunks_of_text
    expect(chunks.count).to eql(16)
    expect(chunks[0]).to match(/\AR001145-040123/)
    expect(chunks[8]).to match(/\AB000992-040323/)
    expect(chunks[8]).to match(/much, Susan\z/)
    expect(chunks[9]).to match(/\AR001149-040323/)
  end

  it "rows" do
    rows = csvify.rows
    expect(rows.count).to eql(16)
    expect(rows[0][0 ... 4]).to eql(["R001145-040123", "2023-04-01", "2023-04-07", "OPC"])
    expect(rows[0][4]).to match(/\ADave Greenup/)
    expect(rows[15][0 ... 4]).to eql(["R001154-040323", "2023-04-03", "", "Inspectional Services"])
    expect(rows[15][4]).to match(/\AMARIA REYES/)
  end

  it "rows w/o requests.csv" do
    csvify.instance_variable_set :@requests, {}
    rows = csvify.rows
    expect(rows[0][0 ... 4]).to eql(["R001145-040123", "2023-04-01", "2023-04-07", ""])
    expect(rows[0][4]).to match(/\AOPC/)
  end
end
