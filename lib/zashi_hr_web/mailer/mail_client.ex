defmodule ZashiHR.MailClient do

  alias Bamboo.Email
  alias ZashiHR.Mailer

  @invitation_template """
  <h3>Congratulations! You have been invited to join Zashi HR</h3>
  This is your invitation token <h4 style="color:red">%TOKEN%</h4>
  """

  @verification_code_template """
  Hi,
  <br><br>
  Enter this code to finishing signing up on your Players’ Lounge Connect: %CODE%
  <br><br>
  If you didn’t request this code, you can ignore this email.
  """

  def send_invitation_link(email, token) do
    body = String.replace(@invitation_template, "%TOKEN%", token)

    Email.new_email()
    |> Email.to(email)
    |> Email.from("dani.uribe16@gmail.com")
    |> Email.subject("Congratulations! You have been invited to join Zashi HR")
    |> Email.html_body(body)
    |> Mailer.deliver_later()
  end

  def send_verification_code(email, code) do
    subject = String.replace("%CODE% is your Player's Lounge Connect code", "%CODE%", code)
    body = String.replace(@verification_code_template, "%CODE%", code)

    Email.new_email()
    |> Email.from("notifications@playerslounge.co")
    |> Email.to(email)
    |> Email.subject(subject)
    |> Email.html_body(body)
    |> IO.inspect(label: "####################")
    |> Mailer.deliver_now()
  end
end
