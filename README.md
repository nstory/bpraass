## Boston Public Records as a Spreadsheet (BPRaaSS)
This project creates [output/table.csv](output/table.csv). This is a
spreadsheet containing all the public records requests made by the public
to the City of Boston from approximately 2017 through April 2023.

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
