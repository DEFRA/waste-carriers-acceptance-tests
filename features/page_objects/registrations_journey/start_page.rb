# frozen_string_literal: true

class StartPage < SitePrism::Page

  set_url("/")

  element(:new_registration, "#registration_newOrRenew_new")
  element(:renew_registration, "#registration_newOrRenew_renew")

  element(:submit_button, "#continue")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:start_option]).select_option

    submit_button.click
  end

end
