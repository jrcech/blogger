FROM ruby:3.1.2

LABEL maintainer="jiricech94@gmail.com"

ENV BUNDLE_PATH /gems

WORKDIR /app

RUN bash -c "curl -sL https://deb.nodesource.com/setup_18.x | bash - \
    && curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -yqq && apt-get install -yqq --no-install-recommends nodejs yarn \
    && apt-get clean"

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY package.json yarn.lock ./
RUN yarn install

COPY . .

RUN yarn build
RUN yarn build:css

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
