class EditAccountEmailPage < SitePrism::Page

  # This page object is not currently called

  element(:notice, ".validation-summary.notice")
  element(:back_link, "a[href*='/registrations']")

  # Cannot simply use the CSS # id selector because there are 2 elements on the
  # page with this id; one a div the other an input
  element(:email_address, "input[id='registration_accountEmail']")

  element(:submit_button, "#continue")

  def submit(args = {})
    email_address.set(args[:email]) if args.key?(:email)

    submit_button.click
  end
end
