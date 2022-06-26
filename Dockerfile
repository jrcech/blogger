FROM ruby:3.1.2

LABEL maintainer="jiricech94@gmail.com"

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    apt-transport-https

RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | \
    tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update -yqq && apt-get install -yqq --no-install-recommends \
    nodejs \
    yarn

COPY Gemfile* /app/
COPY package.json yarn.lock /app/

WORKDIR /app

RUN bundle install
RUN yarn install

COPY . /app/

RUN yarn build
RUN yarn build:css

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
