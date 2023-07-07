.EXPORT_ALL_VARIABLES:

MUCKROCK_INPUT_FILES=input/City_of_Boston_Public_Records_Requests_2017_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2018_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2019_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2020_Redacted.pdf
MORE_RECENT_INPUT_FILES=input/2021AllRequests_Q1_Redacted.pdf input/2021AllRequests_Q2_Redacted.pdf input/2021AllRequests_Q3_Redacted.pdf input/2021AllRequests_Q4_Redacted.pdf input/2022AllRequests_Q1_Redacted.pdf input/2022AllRequests_Q2_Redacted.pdf input/2022AllRequests_Q3_Redacted.pdf input/2022AllRequests_Q4_Redacted.pdf input/2023AllRequests_Q1.pdf input/2023AllRequests_Q2.pdf
ALL_REQUESTS_CSV=input/AllCityofBostonRequeststoDate_06202023.CSV
INPUT_FILES=$(MUCKROCK_INPUT_FILES) $(MORE_RECENT_INPUT_FILES)
OUTPUT_PDF_FILES=$(patsubst input/%,output/%,$(INPUT_FILES))
OUTPUT_CSV_FILES=$(patsubst input/%.pdf,output/%.csv,$(INPUT_FILES))

.PHONY: all
all: $(OUTPUT_PDF_FILES) $(OUTPUT_CSV_FILES) output/all_requests.csv

.PHONY: clean
clean:
	rm -rf output
	mkdir output

# TARGETS TO DOWNLOAD INPUT FILES

$(MORE_RECENT_INPUT_FILES):
	wget --no-use-server-timestamps https://wokewindows-data.s3.amazonaws.com/$(patsubst input/%,%,$@) -O $@

input/City_of_Boston_Public_Records_Requests_2020_Redacted.pdf:
	wget --no-use-server-timestamps "https://cdn.muckrock.com/foia_files/2021/04/12/City_of_Boston_Public_Records_Requests_2020_Redacted.pdf" -O $@
input/City_of_Boston_Public_Records_Requests_2018_Redacted.pdf:
	wget --no-use-server-timestamps "https://cdn.muckrock.com/foia_files/2021/04/12/City_of_Boston_Public_Records_Requests_2018_Redacted.pdf" -O $@
input/City_of_Boston_Public_Records_Requests_2017_Redacted.pdf:
	wget --no-use-server-timestamps "https://cdn.muckrock.com/foia_files/2021/04/12/City_of_Boston_Public_Records_Requests_2017_Redacted.pdf" -O $@
input/City_of_Boston_Public_Records_Requests_2019_Redacted.pdf:
	wget --no-use-server-timestamps "https://cdn.muckrock.com/foia_files/2021/04/12/City_of_Boston_Public_Records_Requests_2019_Redacted.pdf" -O $@

$(ALL_REQUESTS_CSV):
	wget --no-use-server-timestamps https://wokewindows-data.s3.amazonaws.com/AllCityofBostonRequeststoDate_06202023.CSV -O $@

# TARGETS TO TRANSFORM THE INPUT

# run input/foo.pdf through ocr and save the output to output/foo.pdf
output/%.pdf: input/%.pdf lib/ocrify.rb
	ruby lib/main.rb ocr $< $@

# create output/foo.csv from (the already ocr'd) output/foo.pdf
output/%.csv : output/%.pdf lib/csvify.rb
	ruby lib/main.rb csv $< $@

output/all_requests.csv: $(OUTPUT_CSV_FILES)
	xsv cat rows $(OUTPUT_CSV_FILES) > $@
