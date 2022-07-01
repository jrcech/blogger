FROM ruby:3.1.2-slim

LABEL maintainer="jiricech94@gmail.com"

WORKDIR /app

RUN bash -c "apt update && \
    apt install -y --no-install-recommends build-essential curl git libpq-dev && \
    curl -sL https://deb.nodesource.com/setup_18.x | bash - && \
    curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list && \
    apt update && apt install -y --no-install-recommends nodejs yarn && \
    apt clean && \
    useradd --create-home ruby && \
    mkdir /gems && chown ruby:ruby -R /gems && \
    chown ruby:ruby -R /app"

ENV BUNDLE_PATH /gems
ENV USER='ruby'

USER ruby

COPY --chown=ruby:ruby Gemfile Gemfile.lock ./
RUN bundle install

COPY --chown=ruby:ruby package.json yarn.lock ./
RUN yarn install

COPY --chown=ruby:ruby . .

RUN yarn build
RUN yarn build:css

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
