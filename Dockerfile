FROM ruby:2.3.1
RUN apt-get update -qq && apt-get install -y 
RUN apt-get update && apt-get install -y \
        build-essential \
        libpq-dev nodejs \
        libqt4-dev \
        libqtwebkit-dev
RUN mkdir /fugacious
WORKDIR /fugacious
ADD . /fugacious
RUN bin/setup
