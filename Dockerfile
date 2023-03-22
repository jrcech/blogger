FROM ruby:3.2.1-slim AS assets
LABEL maintainer="jiricech94@gmail.com"

WORKDIR /app

ENV BUNDLE_PATH="/gems" \
  DEBIAN_FRONTEND="noninteractive"

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update && \
    apt-get install -y --no-install-recommends build-essential curl git libpq-dev && \
    curl -fsSL https://deb.nodesource.com/setup_19.x | bash - && \
    curl -fsSL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo 'deb https://dl.yarnpkg.com/debian/ stable main' | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && apt-get install -y --no-install-recommends nodejs yarn && \
    rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
    apt-get clean && \
    useradd --create-home ruby && \
    mkdir /gems && chown ruby:ruby -R /gems && \
    chown ruby:ruby -R /app

USER ruby

COPY --chown=ruby:ruby Gemfile Gemfile.lock ./
RUN bundle install

COPY --chown=ruby:ruby package.json yarn.lock ./
RUN yarn install --no-cache

COPY --chown=ruby:ruby . .

ARG RAILS_ENV="development"
ARG NODE_ENV="development"
ARG RAILS_STAGING="false"

ENV RAILS_ENV="${RAILS_ENV}" \
  NODE_ENV="${NODE_ENV}" \
  RAILS_STAGING="${RAILS_STAGING}" \
  USER="ruby"

RUN yarn build
RUN yarn build:css

FROM ruby:3.2.1-slim AS app
LABEL maintainer="jiricech94@gmail.com"

WORKDIR /app

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential curl git libpq-dev nano && \
  rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
  apt-get clean && \
  useradd --create-home ruby && \
  chown ruby:ruby -R /app

USER ruby

ENV BUNDLE_PATH="/gems" \
  USER="ruby" \
  DEBIAN_FRONTEND="noninteractive"

COPY --chown=ruby:ruby --from=assets /gems /gems
COPY --chown=ruby:ruby --from=assets /app/app/assets/builds /app/assets/builds
COPY --chown=ruby:ruby . .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
