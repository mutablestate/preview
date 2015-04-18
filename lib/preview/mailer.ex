defmodule Preview.Mailer do
  use Mailgun.Client, domain: Application.get_env(:preview, :mailgun_domain),
                      key:    Application.get_env(:preview, :mailgun_key)

  @from "yoda@example.com"

  def send_welcome_email(signup) do
    send_email to: signup.email,
               from: @from,
               subject: "Preview registration",
               html: "<p>Welcome to Preview!</p>
                      <p>View or contribute to the source code on <a href='https://github.com/mutablestate/preview'>GitHub</a>.</p>
                      <p>Follow me on Twitter <a href='https://twitter.com/mutablestate'>@mutablestate</a></p>."
  end
end

