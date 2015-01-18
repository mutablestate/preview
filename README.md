# Preview
[![Build
Status](https://travis-ci.org/mutablestate/preview.svg?branch=master "Build
Status")](http://travis-ci.org/mutablestate/preview)

A pre-launch starter app written in Elixir Language on Phoenix Web Framework with the Bourbon family.

Use as a placeholder to market an upcoming site and gauge interest.

It simply collects email addresses, sends an email welcome message and allows
an admin user to login and view signed up emails.

## Demo

[http://preview.elixircnx.com](http://preview.elixircnx.com)

## Setup

1. Add a postgresql database for Preview to use

  Configure ecto for your environments - we're using deploy as our db user and preview_dev as our db name

  ```elixir    
  # config/dev.exs

  config :preview, Preview.Repo,
    database: "preview_dev",
    username: "deploy",
    password: Application.get_env(:preview, :postgres_pass),
    hostname: "localhost"
  ```

2. Add config listed environment variables to your machine

  ```
  export POSTGRES_PASS="my_postgres_password"
  export MAILGUN_KEY="my_mailgun_api_key"
  export MAILGUN_DOMAIN="my_mailgun_domain"
  ```

3. Clone, compile with dependencies and run the migrations

  ```
  git clone https://github.com/mutablestate/preview.git
  mix do deps.get, compile
  mix ecto.migrate Preview.Repo
  ```

4. Add the admin user

  Customize the username and password

  ```elixir
  # priv/repo/seeds.ex

  user = %{
           username: "my_admin_email_address",
           password: Comeonin.hashpwsalt("my_admin_password")
         }
  ```

  Run `mix run priv/repo/seeds.ex` from the Preview root directory

5. Setup the mailer

  Customize the welcome email message sent to signups by changing these lines

  ```elixir    
  # lib/preview/mailer.ex

  @from : "my_email_address"

  subject: "Preview registration",
  body: "Welcome to Preview! Follow me on Twitter @mutablestate."
  ```

6. Start the Phoenix server

  Run `mix phoenix.server` from the Preview root directory

  Visit [http://localhost:4000](http://localhost:4000) in your browser

## Deployment guides

- [Official Phoenix Framework Deployment Guide](http://www.phoenixframework.org/v0.8.0/docs/deployment)
- [Deploy Phoenix Application to a Ubuntu Server](http://learnelixir.com/blog/2014/10/16/deploy-phoenix-application-to-a-ubuntu-server/)
- [Deploy Phoenix Application to Heroku](http://learnelixir.com/blog/2014/10/15/deploy-phonenix-application-to-heroku-server/)
- [Phoenix Flying High: Deploying Phoenix The Final Part](http://www.elixirdose.com/post/phoenix-flying-high-deploying-phoenix-the-final-part)

## Development Notes

- Preview uses SASS. To compile to CSS when modified use `sass --watch priv/static/sass:priv/static/css` if you have the [sass rubygem](http://rubygems.org/gems/sass), otherwise try [Koala](http://koala-app.com).
- Integration tests are configured to use the PhantomJS driver for [hound](https://github.com/HashNuke/hound).
- To exclude integration tests from a test run `mix test --exclude integration`

## Goals

- An opinionated starting point to develop Elixir / Phoenix sites
- Use the latest stable Phoenix release (currently at 0.8.0)
- Discover, learn and have fun!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Status

Preview is not ready for prime-time and Phoenix is not yet at 1.0, however, we encourage you to try it out and give us your feedback.

## License
MIT
