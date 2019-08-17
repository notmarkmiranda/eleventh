FROM ruby:alpine

RUN apk add --update build-base postgresql-dev tzdata nodejs npm
RUN npm install -g yarn
RUN gem install rails -v '5.2.2'

WORKDIR /app
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install
RUN echo ls -lha
ADD . .

RUN RAILS_ENV=production bundle exec rake assets:precompile
CMD bundle exec puma -C config/puma.rb

