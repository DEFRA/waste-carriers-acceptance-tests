class FrontOfficeDashboard < BasePage

  element(:heading, "h1")
  element(:content, "#main-content")

  element(:change_password_link, "a[href*='fo/users/edit-password']")
  element(:sign_out, "a[href*='/fo/users/sign_out']")

  sections(:registration_info, "table tbody tr:nth-child(odd)") do
    element(:name, "td:nth-child(1)")
    element(:postcode, "td:nth-child(2)")
    element(:reg_number, "td:nth-child(3)")
    element(:status, "td:nth-child(4)")
    element(:expiry_date, "td:nth-child(5)")
  end

  sections(:registration_controls, ".registration-list") do
    element(:reg_no, ".column-one-quarter:nth-child(2) li:nth-child(1)")
    element(:renew_registration, "li:nth-child(3) a")
  end

  elements(:renewals, "[href*='/renew']")

  element(:next_page, "a[aria-label='Next page']")
  element(:last_page, "a[aria-label='Last page']")

  def renew(registration_number)
    element = "##{registration_number} a[href$='/renew']"
    find(:css, element).click
  end

  def check_status(registration_number)
    element = "##{registration_number} .column-one-quarter:nth-child(3) li+ li"
    find(:css, element).text
  end

  def find_registration(registration_number)
    found = false
    loop do

      found = page.has_content?(registration_number)
      break if found

      begin
        last_page
      rescue StandardError
        break
      end

      next_page.click
    end

    raise "Registration not found" unless found
  end

end
