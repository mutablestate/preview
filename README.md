# Preview

A pre-launch starter app written in Elixir Language on Phoenix Web Framework with the Bourbon family.

Use as a placeholder to market an upcoming site and gauge interest.

It simply collects email addresses, sends an email welcome message and allows
an admin user to login and view signed up emails.

## Setup

1. Add a postgresql database for Preview to use

  By default we're using deploy as our db user and preview_development as our db name

  ```elixir    
  # web/models/repo.exs

  parse_url "ecto://deploy:#{config_postgres_pass}@localhost/preview_development"
  ```

2. Setup expected environment variables

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

4. Setup the mailer

  Customize the welcome email message sent to signups by changing these lines

  ```elixir    
  # lib/preview/mailer.ex

  @from : "my_email_address"

  subject: "Preview registration",
  body: "Welcome to Preview! Follow me on Twitter @mutablestate."
  ```

5. Manually add a user to act as admin

  Run `iex -S mix` from the Preview root directory

  ```elixir
  import Preview.User
  import Preview.Repo
  alias Preview.Repo
  alias Preview.User

  fields = [username: "my_email_address", password: Comeonin.hashpwsalt("my_password")]
  user = struct(User, fields)
  Repo.insert(user)
  ```

6. Start the Phoenix server

  Run `mix phoenix.start` from the Preview root directory

  Visit [http://localhost:4000](http://localhost:4000) in your browser

## Deployment guides

- [Official Phoenix Framework Guide](http://www.phoenixframework.org/v0.7.2/docs/deployment)
- [Deploy Phoenix Application to a Ubuntu Server](http://learnelixir.com/blog/2014/10/16/deploy-phoenix-application-to-a-ubuntu-server/)
- [Deploy Phoenix Application to Heroku](http://learnelixir.com/blog/2014/10/15/deploy-phonenix-application-to-heroku-server/)
- [Phoenix Flying High: Deploying Phoenix The Final Part](http://www.elixirdose.com/post/phoenix-flying-high-deploying-phoenix-the-final-part)

## Notes

- Preview uses SASS. You will need to compile it to CSS when modified. If you're new to this procedure give [Koala](http://koala-app.com) a try.

## Goals

- An opinionated starting point to develop Elixir / Phoenix sites
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
