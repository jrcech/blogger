# Blogger

Checkout [DEMO](http://49.12.193.13) application.

## Setup development environment and run the application

Install environment tools:

```shell
asdf install
```

Start your database server:

```shell
pg_ctl start
```

Add postgres role:

```shell
createuser -U postgres --interactive
```

> You will be prompted to enter role name and answer if it's a superuser.
> Choose your machine username for role name.
> Choose `y` for superuser role.

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

> If you see error
> like `pg_dump: error: connection to server on socket "/tmp/.s.PGSQL.5432" failed: FATAL:  role "jrcech" does not exist`
> you need to create postgres role with your machine username.

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

Update Gemfile Bundler version:

```shell
bundle update --bundler
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

### Update Docker development environment

Update `Dockerfile` to use the latest Ruby version:

```shell
FROM ruby:3.2.2-slim AS assets

FROM ruby:3.2.2-slim AS app
```

## Deploy application to staging environment

Generate SSH key pair for GitHub:
```shell
ssh-keygen -t ed25519 -a 100 -f path/to/keyfile
```
