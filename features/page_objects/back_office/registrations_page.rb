class RegistrationsPage < SitePrism::Page

  # Registration search
  element(:new_registration, "#new_registration")
  element(:registration_export, "a[href*='reports/registrations']")
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
    element(:view_certificate, :xpath, "//a[contains(.,'View certificate)]")
    element(:edit_registration, :xpath, "//a[contains(.,'Edit registration')]")
    element(:change_account_email, :xpath, "//a[contains(.,'Change Account Email')]")
    element(:de_register, :xpath, "//a[contains(.,'De-Register')]")
    element(:revoke, :xpath, "//a[contains(.,'Revoke')]")
    element(:approve, :xpath, "//a[contains(.,'Approve')]")
    element(:refuse, :xpath, "//a[contains(.,'Refuse')]")
    element(:renew, :xpath, "//a[contains(.,'Renew')]")
    element(:payment_status, :xpath, "//a[contains(@id,'paymentStatus')]")

  end

  def search(args = {})
    search_input.set(args[:search_input]) if args.key?(:search_input)
    reg_search.click
  end

  def wait_for_status(text_to_check)
    refresh_cnt = 0
    loop do
      if search_results[0].status.text == text_to_check
        refresh_cnt = 20
      else
        # reloads the page if service layer hasn't updated elastic search in time
        page.evaluate_script("window.location.reload()")
        sleep(1)
        refresh_cnt += 1
      end
      break unless refresh_cnt < 20
    end
  end

end
