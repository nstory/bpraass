## Boston Public Records as a Spreadsheet (BPRaaSS)
This project creates [output/table.csv](output/table.csv). This is a
spreadsheet containing all the public records requests made by the public
to the City of Boston from approximately 2017 through April 2023.

This project uses [optical character recognition
(OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition) to extract
text from PDF files provided by the City of Boston. This process is not 100%
accurate; be mindful that the spreadsheet will contain errors.

## Build
Run `make` to build the project. You will need ocrmypdf and poppler (for
pdftotext).

## What are these files and stuff?
 - `input/` contains PDF files provided by [Boston Public
   Records](https://www.boston.gov/departments/public-records)
 - `output/*.pdf` are the PDF files run through
   [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF). This is necessary because
   some pages are images (not text)
 - `output/*.txt` the text from the OCR'd PDF files; extracted using pdftotext
 - [output/table.csv](output/table.csv) a spreadsheet created from the .txt
   files

## See also
- [FOIA Request: FOIA logs for years 2016, 2017, 2018, 2019 and 202](https://www.muckrock.com/foi/boston-3/foia-request-foia-logs-for-years-2016-2017-2018-2019-and-2020-103036/)
- [PRR: Boston Public Records Request Log 2021 to Present](https://blog.wokewindows.org/2023/04/19/boston-prr-log.html)
- [Boston Public Records Log](https://blog.wokewindows.org/2021/01/14/boston-public-records-log.html)
  and [nstory/boston_public_records](https://github.com/nstory/boston_public_records) for my previous work with the 2017 - 2020 files
