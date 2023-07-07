FROM alpine:3.18
RUN apk add --no-cache make ocrmypdf poppler-utils ruby wget tesseract-ocr-data-eng xsv
RUN gem install bundler --version "2.4.12"
COPY Gemfile Gemfile.lock ./
RUN bundle install
WORKDIR /app
