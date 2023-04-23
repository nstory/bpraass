.EXPORT_ALL_VARIABLES:

MUCKROCK_INPUT_FILES=input/City_of_Boston_Public_Records_Requests_2017_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2018_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2019_Redacted.pdf input/City_of_Boston_Public_Records_Requests_2020_Redacted.pdf
MORE_RECENT_INPUT_FILES=input/2021AllRequests_Q1_Redacted.pdf input/2021AllRequests_Q2_Redacted.pdf input/2021AllRequests_Q3_Redacted.pdf input/2021AllRequests_Q4_Redacted.pdf input/2022AllRequests_Q1_Redacted.pdf input/2022AllRequests_Q2_Redacted.pdf input/2022AllRequests_Q3_Redacted.pdf input/2022AllRequests_Q4_Redacted.pdf input/2023AllRequests_Q1.pdf input/2023AllRequests_Q2.pdf
INPUT_FILES=$(MUCKROCK_INPUT_FILES) $(MORE_RECENT_INPUT_FILES)
OUTPUT_PDF_FILES=$(patsubst input/%,output/%,$(INPUT_FILES))
OUTPUT_TXT_FILES=$(patsubst input/%.pdf,output/%.txt,$(INPUT_FILES))

# tell make to not delete these files even though they are intermediate files
.PRECIOUS: $(OUTPUT_PDF_FILES) $(OUTPUT_TXT_FILES)

.PHONY: all
all: output/table.csv

.PHONY: clean
clean:
	rm -rf output
	mkdir output
	touch output/.keep

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

output/%.pdf: input/%.pdf
	# the default output-type pdf/a is corrupting text on skipped pages
	ocrmypdf --output-type pdf --skip-text $< $@

output/%.txt : output/%.pdf
	pdftotext -layout $<

output/table.csv: lib/tableify.rb $(OUTPUT_TXT_FILES)
	ruby lib/tableify.rb > $@
