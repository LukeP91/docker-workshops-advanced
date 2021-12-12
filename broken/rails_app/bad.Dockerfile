FROM node
FROM ruby

EXPOSE 3000

ARG MESSAGE

ENV HELLO=$MESSAGE

RUN mkdir -p /app

ADD . /app
WORKDIR /app

RUN apt-get update -qq
RUN apt-get install -y nodejs postgresql-client build-essential libpq-dev

RUN bundle install

# Configure the main process to run when running the image
CMD rails server -b 0.0.0.0
