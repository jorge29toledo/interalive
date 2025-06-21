FROM ruby:3.3.7

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

EXPOSE 3000
