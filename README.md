# Boston Public Records as a Spreadsheet (BPRaaSS)
The City of Boston provided us with PDF documents showing all the public records
requests made to the city. This project converts those PDFs into CSV files that
can be conveniently worked with in Excel.

You probably want to download one or more of these files:

- [output/2021AllRequests_Q1_Redacted.csv](output/2021AllRequests_Q1_Redacted.csv)
- [output/2021AllRequests_Q2_Redacted.csv](output/2021AllRequests_Q2_Redacted.csv)
- [output/2021AllRequests_Q3_Redacted.csv](output/2021AllRequests_Q3_Redacted.csv)
- [output/2021AllRequests_Q4_Redacted.csv](output/2021AllRequests_Q4_Redacted.csv)
- [output/2022AllRequests_Q1_Redacted.csv](output/2022AllRequests_Q1_Redacted.csv)
- [output/2022AllRequests_Q2_Redacted.csv](output/2022AllRequests_Q2_Redacted.csv)
- [output/2022AllRequests_Q3_Redacted.csv](output/2022AllRequests_Q3_Redacted.csv)
- [output/2022AllRequests_Q4_Redacted.csv](output/2022AllRequests_Q4_Redacted.csv)
- [output/2023AllRequests_Q1.csv](output/2023AllRequests_Q1.csv)
- [output/2023AllRequests_Q2.csv](output/2023AllRequests_Q2.csv)
- [output/City_of_Boston_Public_Records_Requests_2017_Redacted.csv](output/City_of_Boston_Public_Records_Requests_2017_Redacted.csv)
- [output/City_of_Boston_Public_Records_Requests_2018_Redacted.csv](output/City_of_Boston_Public_Records_Requests_2018_Redacted.csv)
- [output/City_of_Boston_Public_Records_Requests_2019_Redacted.csv](output/City_of_Boston_Public_Records_Requests_2019_Redacted.csv)
- [output/City_of_Boston_Public_Records_Requests_2020_Redacted.csv](output/City_of_Boston_Public_Records_Requests_2020_Redacted.csv)
- [output/all_requests.csv](output/all_requests.csv) this is all the other files concatenated together

## Nota bene
This project uses [optical character recognition
(OCR)](https://en.wikipedia.org/wiki/Optical_character_recognition) to extract
text from PDF files provided by the City of Boston. This process is not 100%
accurate; be mindful that the spreadsheet will contain errors.

## Build
```
$ docker compose build && docker compose run app
$ make clean all
```

## What are these files and stuff?
 - `input/*.pdf` PDF files provided by [Boston Public Records](https://www.boston.gov/departments/public-records)
 - `input/AllCityofBostonRequeststoDate_06202023.CSV` CSV file provided by the city that contains some columns
 - `output/*.pdf` are the PDF files run through [OCRmyPDF](https://github.com/ocrmypdf/OCRmyPDF). This is necessary because some pages are images (not text)
 - `output/*.csv` spreadsheets created from the .pdf files

## See also
- [FOIA Request: FOIA logs for years 2016, 2017, 2018, 2019 and 202](https://www.muckrock.com/foi/boston-3/foia-request-foia-logs-for-years-2016-2017-2018-2019-and-2020-103036/)
- [PRR: Boston Public Records Request Log 2021 to Present](https://blog.wokewindows.org/2023/04/19/boston-prr-log.html)
- [Boston Public Records Log](https://blog.wokewindows.org/2021/01/14/boston-public-records-log.html)
  and [nstory/boston_public_records](https://github.com/nstory/boston_public_records) for my previous work with the 2017 - 2020 files

## LICENSE
This project is released under the MIT License.
