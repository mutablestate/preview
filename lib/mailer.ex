defmodule Preview.Mailer do
  use Mailgun.Client, domain: Application.get_env(:preview, :mailgun_domain),
                      key: Application.get_env(:preview, :mailgun_key)

  @from "my_email_address"

  def send_welcome_email(signup) do
    send_email to: signup.email,
               from: @from,
               subject: "Preview registration",
               body: "Welcome to Preview! Follow me on Twitter @mutablstate."
  end
end

