FROM ruby:3.3

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN gem install rails -v 8.1.3.1
RUN bundle install
