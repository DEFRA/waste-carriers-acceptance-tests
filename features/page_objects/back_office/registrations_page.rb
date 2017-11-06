class RegistrationsPage < SitePrism::Page

  # Registration search
  element(:new_registration, "#new_registration")
  element(:search_input, "#q")
  element(:reg_search, "#reg-search")

  element(:sign_out, "#signout_button")

  sections :search_results, ".agency-edit" do
    element :reg_name, "div:nth-child(1) > div > ul > li:nth-child(1) > p"
    element :postcode, "div:nth-child(1) > div > ul > li:nth-child(2) > p"
    element :registration_number, "div:nth-child(2) > div > ul > li:nth-child(1) > p"
    element :status, "div:nth-child(2) > div > ul > li:nth-child(2) > p"
    element :date_registered, "div:nth-child(3) > div > ul > li:nth-child(1) > p"
    element :expiry_date, "div:nth-child(3) > div > ul > li:nth-child(2) > p"
    # Actions
    element(:view_certificate, "a[href*='view']")
    element(:edit_registration, "a[href*='edit_process']")
    element(:change_account_email, "a[href*='edit_account_email']")
    element(:de_register, "a[href*='confirm_delete']")
    element(:revoke, "a[href*='revoke']")
    element(:payment_status, "a[href*='paymentstatus']")
  end

  def search(args = {})
    search_input.set(args[:search_input]) if args.key?(:search_input)
    reg_search.click
  end

end
