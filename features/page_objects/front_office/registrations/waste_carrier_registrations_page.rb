class WasteCarrierRegistrationsPage < SitePrism::Page

  element(:heading, ".heading-large")

  sections(:registration_info, "table tbody tr:nth-child(odd)") do
    element(:name, "td:nth-child(1)")
    element(:postcode, "td:nth-child(2)")
    element(:reg_number, "td:nth-child(3)")
    element(:status, "td:nth-child(4)")
    element(:expiry_date, "td:nth-child(5)")
  end

  sections(:registration_controls, ".registration-list") do
    element(:reg_no, ".column-one-quarter:nth-child(2) li:nth-child(1)")
    element(:view_certificate, "li:nth-child(1) a")
    element(:edit_registration, "li:nth-child(2) a")
    element(:renew_registration, "li:nth-child(3) a")
    element(:order_copy_cards, "li:nth-child(4) a")
    # element(:delete, "li:nth-child(5) a")
    element(:delete, "[href*='/confirm_delete']")
  end

  elements(:edits, "[href*='/edit']")
  elements(:renewals, "[href*='/renew']")
  elements(:deletes, "[href*='/confirm_delete']")

  element(:sign_out, "#signout_button")

  element(:next_page, "a[aria-label='Next page']")
  element(:last_page, "a[aria-label='Last page']")

  def view_certificate(registration_number)
    element = "#" + registration_number.to_s + " li:nth-child(1) a"
    find(:css, element).click
  end

  def renew(registration_number)
    element = "#" + registration_number.to_s + " li:nth-child(3) a"
    find(:css, element).click
  end

  def delete(registration_number)
    element = "#" + registration_number.to_s + " li:nth-child(5) a"
    find(:css, element).click
  end

  def edit(registration_number)
    element = "#" + registration_number.to_s + " li:nth-child(2) a"
    find(:css, element).click
  end

  def check_status(registration_number)
    element = "#" + registration_number.to_s + " .column-one-quarter:nth-child(3) li+ li"
    find(:css, element).text
  end

  def renewable?(registration_number)
    element = "#" + registration_number.to_s + " li:nth-child(3) a"
    element_txt = find(:css, element).text
    element_txt.include? "Renew"
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
