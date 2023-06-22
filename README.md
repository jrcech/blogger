# Blogger

## Setup development environment and run the application

Install environment tools:

```shell
asdf install
```

Start your database server:

```shell
pg_ctl start
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
overmind start
```

Test your application with:

```shell
rspec
```

Shorthand script:

```shell
asdf install
pg_ctl start
cp .env.development.example .env
rails db:setup
overmind start
```


---

https://thurlow.io/ruby/2020/11/06/remote-selenium-webdriver-servers-with-rails-capybara-and-rspec.html
