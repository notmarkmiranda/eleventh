FROM ruby:alpine

RUN apk add --update build-base postgresql-dev tzdata
RUN gem install rails -v '5.2.2'

WORKDIR /app
ADD Gemfile Gemfile.lock /app/
RUN bundle install

ADD . .
RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD bundle exec puma -C config/puma.rb

