# Preview

A pre-launch starter app written in Elixir Language on Phoenix Web Framework with the Bourbon family.

It simply collects email addresses of interested visitors and sends them a welcome message.

An admin is able to login and view stored emails.

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
  ```

3. Clone, compile with dependencies and run the migrations

  ```
  git clone https://github.com/mutablestate/preview.git
  mix do deps.get, compile
  mix ecto.migrate Preview.Repo
  ```

4. Setup mailer

Add your mailgun domain to the config for your environment

  ```elixir    
  # config/dev.exs
  # config/prod.exs
  # config/test.exs

  mailgun_domain: "my_mailgun_domain"
  ```

Customize the welcome message by changing these lines

  ```elixir    
  # lib/mailer.ex

  @from : "my_email_address"

  subject: "Preview registration",
  body: "Welcome to Preview! Follow me on Twitter @mutablstate."
  ```

5. Manually add a user to act as admin

Run `iex -S mix` from the Preview root directory

  ```
  import Preview.User
  import Preview.Repo
  alias Preview.Repo
  alias Preview.User

  fields = [username: "my_email_address", password: Preview.Crypto.md5("my_password")]
  user = struct(User, fields)
  Repo.insert(user)
  ```

6. UI Development

Preview uses sass. You will need to compile it to css when modified.
If you're new to this procedure give Koala a try.

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
