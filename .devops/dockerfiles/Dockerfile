FROM ruby:2.7.2

WORKDIR /stalker

RUN apt-get update && rm -rf /var/lib/apt/lists/*

COPY . .

RUN gem install bundler -v 2.1.4 && bundle _2.1.4_ install
