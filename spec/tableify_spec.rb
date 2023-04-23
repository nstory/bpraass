require "pry"
require "./lib/tableify.rb"

describe "tableify" do
  describe "parse_id" do
    {
      "B000003-010222 1/2/2022        1/3/2022    BAT XXX YYYY" => {id: "B000003-010222", created: "1/2/2022", closed: "1/3/2022"},
      "RO03650-122722    12/25/2022   2/3/2023           Xyyyy Yxxxx" => {id: "R003650-122722", created: "12/25/2022", closed: "2/3/2023"},
      "B001096-041023 4/10/2023                    OPC        Sxxxxxxx" => {id: "B001096-041023", created: "4/10/2023", closed: nil},
      "B001805-070722   7712022   712212022   XX Yxxxxx         Xyyy Yxxxxx" => {id: "B001805-070722", created: nil, closed: nil},
      "                                                                                                                                          trust-act-boston-police-handed-over-immigrants-for-deportation/XYZyQbxytbN2z6WpnN8ArM/story.html?" => nil,
    }.each do |input, output|
      it "#{input} => #{output}" do
        expect(parse_id(input)).to eql(output)
      end
    end
  end
end
