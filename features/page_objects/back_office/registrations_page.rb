class RegistrationsPage < SitePrism::Page

  # Registration search
  element(:new_registration, "#new_registration")
  element(:search_input, "#q")
  element(:reg_search, "#reg-search")
  element(:first_search_result_payment_status_action, "#paymentStatus1")
  element(:first_search_result_reg_status, :xpath, ".//*[@id='searchResult1']/div[2]/div/ul/li[2]/p")

  element(:sign_out, "#signout_button")

  sections :search_results, ".agency-edit" do
    element(:view_certificate, "a[href*='view']")
    element(:edit_registration, "a[href*='edit_process']")
    element(:change_account_email, "a[href*='edit_account_email']")
    element(:de_register, "a[href*='confirm_delete']")
    element(:revoke, "a[href*='revoke']")
  end

  def search(args = {})
    search_input.set(args[:search_input]) if args.key?(:search_input)
    reg_search.click
  end

end
