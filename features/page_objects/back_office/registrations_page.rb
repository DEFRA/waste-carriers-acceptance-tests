class RegistrationsPage < SitePrism::Page

  # Registration search
  element(:new_registration, "#new_registration")
  element(:search_input, "#q")
  element(:reg_search, "#reg-search")
  element(:first_search_result_payment_status_action, "#paymentStatus1")
  element(:first_search_result_reg_status, :xpath, ".//*[@id='searchResult1']/div[2]/div/ul/li[2]/p")

  element(:sign_out, "#signout_button")

  def search(args = {})
    search_input.set(args[:search_input]) if args.key?(:search_input)
    reg_search.click
  end

end
