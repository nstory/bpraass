INPUT_FILES=input/2021AllRequests_Q1_Redacted.pdf input/2021AllRequests_Q2_Redacted.pdf input/2021AllRequests_Q3_Redacted.pdf input/2021AllRequests_Q4_Redacted.pdf input/2022AllRequests_Q1_Redacted.pdf input/2022AllRequests_Q2_Redacted.pdf input/2022AllRequests_Q3_Redacted.pdf input/2022AllRequests_Q4_Redacted.pdf input/2023AllRequests_Q1.pdf input/2023AllRequests_Q2.pdf

.PHONY: all
all: download ocr text output/table.csv

.PHONY: clean
clean:
	rm -rf output
	mkdir output
	touch output/.keep

$(INPUT_FILES):
	wget https://wokewindows-data.s3.amazonaws.com/$(patsubst input/%,%,$@) -O $@

.PHONY: download
download: $(INPUT_FILES)

output/%.pdf: input/%.pdf
	ocrmypdf --force-ocr $< $@

.PHONY: ocr
ocr: $(patsubst input/%,output/%,$(wildcard input/*.pdf))

output/%.txt : output/%.pdf
	pdftotext -layout $<

# .PHONY: text
# text: $(patsubst %.pdf,%.txt,$(wildcard output/*.pdf))

.PHONY: text
text: $(patsubst input/%.pdf,output/%.txt,$(wildcard input/*.pdf))

output/table.csv: lib/tableify.rb $(patsubst input/%.pdf,output/%.txt,$(wildcard input/*.pdf))
	ruby lib/tableify.rb > $@
