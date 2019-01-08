class WasteCarrierRegistrationsPage < SitePrism::Page

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
    element(:delete, "li:nth-child(5) a")
  end

  elements(:edits, "[href*='/edit']")
  elements(:renewals, "[href*='/renew']")
  element(:sign_out, "#signout_button")

  element(:next_page, "a[aria-label='Next page']")
  element(:last_page, "a[aria-label='Last page']")

  def edit(args = {})
    return unless args.key?(:reg)

    search_val = "edit_#{args[:reg]}"
    edits.find { |chk| chk["id"] == search_val }.click
  end

  def renew(args = {})
    return unless args.key?(:reg)

    search_val = "renew_#{args[:reg]}"
    renewals.find { |chk| chk["id"] == search_val }.click
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
