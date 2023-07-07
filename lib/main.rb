require "csv"
require "pry"
require "./lib/ocrify.rb"
require "./lib/csvify.rb"

def ocr(input_file, output_file)
  Ocrify.new(input_file: input_file, output_file: output_file).call
end

def csv(input_file, output_file)
  Csvify.new(input_file: input_file, output_file: output_file, requests_csv: ENV.fetch("ALL_REQUESTS_CSV")).call
end

if $PROGRAM_NAME == __FILE__
  send(ARGV[0].to_sym, *ARGV[1 .. -1])
end
