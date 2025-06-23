FROM ruby:3.3.7

RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  postgresql-client \
  yarn \
  procps \
  watchman

WORKDIR /app

COPY Gemfile* ./
RUN bundle install

COPY . .

RUN bundle exec rails tailwindcss:build

EXPOSE 3000
