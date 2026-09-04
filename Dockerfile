FROM ruby:3.3

RUN gem install rails -v 7.1.5.1

WORKDIR /app
