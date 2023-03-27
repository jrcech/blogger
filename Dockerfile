FROM ruby:3.2.1-slim AS assets
LABEL maintainer="jiricech94@gmail.com"

WORKDIR /app

ARG UID=1000
ARG GID=1000

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
    groupadd -g "${GID}" ruby && \
    useradd --create-home --no-log-init -u "${UID}" -g "${GID}" ruby && \
    mkdir /gems && chown ruby:ruby -R /gems && \
    mkdir /node_modules && chown ruby:ruby -R /node_modules /app

USER ruby

COPY --chown=ruby:ruby Gemfile Gemfile.lock ./
RUN bundle install

COPY --chown=ruby:ruby package.json yarn.lock ./
RUN yarn install --no-cache

COPY --chown=ruby:ruby . .

ARG RAILS_ENV="development"
ARG RAILS_STAGING="false"
ARG NODE_ENV="development"

ENV RAILS_ENV="${RAILS_ENV}" \
  NODE_ENV="${NODE_ENV}" \
  RAILS_STAGING="${RAILS_STAGING}" \
  USER="ruby"

RUN if [ "${RAILS_ENV}" != "development" ]; then \
    RAILS_ENV=production \
    SECRET_KEY_BASE=dummyvalue \
    bundle exec rails assets:precompile; \
  fi

FROM ruby:3.2.1-slim AS app
LABEL maintainer="jiricech94@gmail.com"

WORKDIR /app

ARG UID=1000
ARG GID=1000

RUN apt-get update && \
  apt-get install -y --no-install-recommends build-essential curl git libpq-dev nano && \
  rm -rf /var/lib/apt/lists/* /usr/share/doc /usr/share/man && \
  apt-get clean && \
  groupadd -g "${GID}" ruby && \
  useradd --create-home --no-log-init -u "${UID}" -g "${GID}" ruby && \
  chown ruby:ruby -R /app

USER ruby

ARG RAILS_ENV="development"

ENV RAILS_ENV="${RAILS_ENV}" \
  BUNDLE_PATH="/gems" \
  USER="ruby" \
  DEBIAN_FRONTEND="noninteractive"

COPY --chown=ruby:ruby --from=assets /gems /gems
COPY --chown=ruby:ruby --from=assets /app/public /public
COPY --chown=ruby:ruby . .

ENTRYPOINT ["./docker-entrypoint.sh"]

CMD ["bin/rails", "s", "-b", "0.0.0.0"]
