FROM ruby:3.1.0

LABEL maintainer="jiricech94@gmail.com"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    nodejs

COPY Gemfile* /usr/src/app/

WORKDIR /usr/src/app
RUN bundle install

COPY . /usr/src/app/

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
