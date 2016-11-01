FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y \
  build-essential

WORKDIR /app

COPY . /app

ENV PORT 3000
ENV RACK_ENV development
ENV RAILS_ENV development
ENV MAX_RETENTION_HOURS 20
ENV SECRET_KEY_BASE shh

RUN bundle install --without devops production
RUN bundle exec rake db:migrate

CMD bundle exec rails s -p $PORT -b 0.0.0.0
