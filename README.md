# Blogger

## Setup environment

The most important file is `.env` which configures many aspects of
application and environment based on desired platform or deploy solution.

In `.env.*.example` are examples based on different environments. In each setup
variation is one such file copied to `.env`. That means every declaration and
usage in application or elsewhere is referenced to only this file.

## Setup development environment and run the application

Install environment tools:

```shell
asdf install
```

Start your database server:

```shell
pg_ctl start
```

Install ruby dependencies with bundle:

```shell
bundle install
```

Install node dependencies with yarn:

```shell
yarn install
```

Copy `.env.development.example` to `.env` and manually change secure values:

```shell
cp .env.development.example .env
```

> This file will work as is, but it's recommended to change password values for
> better security.

Setup your database:

```shell
rails db:setup
```

Start your application in development environment:

```shell
./bin/dev
```

> This is Rails default start command using Foreman. This command also installs
> it if missing.
>
> You can also use other Procfile based tools installed on your
> system like Overmind. In that case you will use `overmind start` instead.

Test your application with:

```shell
rspec
```

Shorthand script:

```shell
asdf install
pg_ctl start

bundle install
yarn install

cp .env.development.example .env

rails db:setup

./bin/dev
```

Customized shorthand script:

```shell
asdf install
pg_ctl start

bundle install
yarn install

cp .env.development.example .env

rails db:setup

overmind start
```

## Setup development environment with Docker and run the application

Copy `.env.development.example` to `.env` and manually change secure values:

```shell
cp .env.development.example .env
```

Compose Docker file `docker-compose.yml`:

```shell
docker compose up -d
```

Migrate the database with `web` container:

```shell
docker compose exec web bundle exec rails db:setup
```

Test your application with:

```shell
docker compose run --rm -e RAILS_ENV=test web bundle exec rspec
```

## Update Rails application and environment tools

Run default Rails update task and manually check all changes:

```shell
rails app:update
```

> You will be prompted to solve every file conflict.
>
> Use `d` to see differences between files.
>
> Use `y` to overwrite or `n` to skip.

Update tools listed in `.tool-versions` to their latest versions:

```shell
asdf local ruby latest
asdf local nodejs latest
asdf local yarn latest
```

Update `Gemfile` to use the latest Ruby and Rails versions:

```ruby
ruby '3.2.2'

gem 'rails', '~> 7.0.5'
```

Install ruby dependencies with bundle:

```shell
bundle install
```

Install node dependencies with yarn:

```shell
yarn install
```

Migrate database:

```shell
rails db:migrate
```

Test the application with:

```shell
rspec
```

> Any failed tests have to be fixed. If fixing is complicated reset changes and
> start over but upgrade one tool at a time and continue only after all tests
> pass.

Update Gemfile Bundler version:

```shell
bundle update --bundler
```

### Update Docker development environment

Update `Dockerfile` to use the latest Ruby version:

```shell
FROM ruby:3.2.2-slim AS assets

FROM ruby:3.2.2-slim AS app
```

---

https://thurlow.io/ruby/2020/11/06/remote-selenium-webdriver-servers-with-rails-capybara-and-rspec.html
