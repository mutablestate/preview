# Preview
[![Build
Status](https://travis-ci.org/mutablestate/preview.svg?branch=master "Build
Status")](http://travis-ci.org/mutablestate/preview)

A Phoenix Framework v0.14.0 pre-launch example application.

Use as a placeholder to promote an upcoming site and gauge interest by collecting email addresses.

The application stores new signup email addresses in a Postgresql database and sends a welcome email with Mailgun.

Click `Login` to enter your admin details (located in `priv/repo/seeds.ex`) to view or download a CSV file of signed up emails.

## Demo

[http://preview.elixircnx.com](http://preview.elixircnx.com)

## Setup

1. Add config listed environment variables to `.profile`

  ```
  export MAILGUN_KEY="my_mailgun_api_key"
  export MAILGUN_DOMAIN="my_mailgun_domain"
  ```

2. Clone, compile with dependencies and run the migrations

  ```
  git clone https://github.com/mutablestate/preview.git
  mix do deps.get, compile
  mix ecto.create
  mix ecto.migrate
  ```

3. Add the admin user

  Customize the username and password

  ```elixir
  # priv/repo/seeds.ex

  user = %{
           email: "yoda@example.com",
           password: Comeonin.Bcrypt.hashpwsalt("usetheforce")
         }
  ```

  Run `mix run priv/repo/seeds.ex` from the Preview root directory

5. Setup the mailer

  Customize the welcome email message sent to signups by changing these lines

  ```elixir    
  # lib/preview/mailer.ex

  @from : "yoda@example.com"

  subject: "Preview registration",
  html: "<p>Welcome to Preview!</p>"
  ```

6. Start the Phoenix server

  Run `mix phoenix.server` from the Preview root directory

  Visit [http://localhost:4000](http://localhost:4000) in your browser

## Deployment guides

- [Official Guide](http://www.phoenixframework.org/v0.14.0/docs/deployment)
- [Official Advanced Guide](http://www.phoenixframework.org/v0.14.0/docs/advanced-deployment)

## Development notes

- The `node_modules` folder is gitignored, re-install with `npm install`.

## Goals

- An opinionated starting point to develop Elixir / Phoenix sites
- Use the latest stable Phoenix release
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
