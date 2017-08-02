class LoginPage < SitePrism::Page

  set_url(Quke::Quke.config.custom["urls"]["back_office"])

  element(:email, "#cred_userid_inputtext")
  element(:password, "#cred_password_inputtext")

  element(:submit_button, "#cred_sign_in_button")

  def submit(args = {})
    email.set(args[:email]) if args.key?(:email)
    password.set(args[:password]) if args.key?(:password)

    # When you first go to the Dynamics url you are first redirected to a
    # general Microsoft sign in page. Part of the functionality of that page is
    # that after entering your email it dynamically checks it for 'reasons' (we
    # think its something to do with its Active Directory stuff, and its
    # deciding whether to redirect you to another page again). Until this check
    # is complete however, you cannot seem to login. Hence we have to put this
    # sleep in to allow it to complete the check.
    sleep(1)
    submit_button.click
  end

end
