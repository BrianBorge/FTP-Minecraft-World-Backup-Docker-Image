FROM ruby:2.6.3

LABEL MAINTAINER="Brian Borge <brianborge@gmail.com>"

VOLUME [ "/backups" ]

RUN gem install 'rubyzip:1.2.3'

COPY . /app

WORKDIR /app

CMD [ "ruby", "/app/entrypoint.rb" ]
