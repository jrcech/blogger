# Blogger – Simple but full of features Blogging Application

Part of the rails_template project. Desired Rails application state after a new generation process from the template.

## How to run this application

There are two ways to run this application:

1. Setting up the development environment
2. Using Docker

### Setting up the development environment

It is recommended to use [ASDF Version Manager](https://asdf-vm.com) to automatically install required tools.
This tool manages multiple runtime versions with a single CLI tool with support for Ruby, Node.js, Postgres, Yarn and
much more.
It is like nvm, pyenv, rbenv, etc. but in a single tool managed with plugins.
For OS specific installation instructions please visit
the [ASDF Getting Started](https://asdf-vm.com/guide/getting-started.html).

Or you can install required development tools yourself, see `.tool-versions` file for required versions.

#### Install required tools as ASDF plugins

If you don't have ASDF plugins installed, do so with the following commands:

```shell
asdf plugin add ruby
asdf plugin add nodejs
asdf plugin add yarn
asdf plugin add postgres
```

Required versions are defined in `.tool-versions` file:

```
ruby 3.2.1
nodejs 19.7.0
yarn 1.22.19
postgres 14.1
```

To install required versions run in the project root directory:

```shell
asdf install
```

#### Install Application dependencies

After installing required tools, you can install application dependencies.

Install Ruby gems with Bundler:

```shell
bundle install
```

Install Node.js packages with Yarn:

```shell
yarn install
```

#### Setup the database 

Start the PostgreSQL server:

```shell
pg_ctl start
```

Create the database, load the schema, and initialize it with seed data:

```shell
rails db:setup
```

#### Start the application

Start the Rails application in development environment:

```shell
./bin/dev
```

### Using Docker

If you prefer to use Docker, you can build and run the application with Docker Compose.

#### Build the Docker image

```shell
docker compose build
```

#### Start the application

```shell
docker compose up
```

#### Setup the database

```shell
docker-compose run web rails db:setup
```
