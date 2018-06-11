class WasteCarrierRegistrationsPage < SitePrism::Page

  sections(:registration_info, "table tbody tr:nth-child(odd)") do
    element(:name, "td:nth-child(1)")
    element(:postcode, "td:nth-child(2)")
    element(:reg_number, "td:nth-child(3)")
    element(:status, "td:nth-child(4)")
    element(:expiry_date, "td:nth-child(5)")
  end

  sections(:registration_controls, "table tbody tr:nth-child(even)") do
    element(:view_certificate, "td:nth-child(1)")
    element(:edit_registration, "td:nth-child(2)")
    element(:renew_registration, "td:nth-child(3)")
    element(:order_copy_cards, "td:nth-child(4)")
    element(:delete, "td:nth-child(5)")
  end

  elements(:edits, "[href*='/edit']")
  elements(:renewals, "[href*='/renew']")
  element(:sign_out, "#signout_button")

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

  def registration(registration_number)
    result = nil

    registration_info.each_with_index do |info, index|
      next unless info.reg_number.text == registration_number
      result = {
        info: info,
        controls: registration_controls[index]
      }
      break
    end

    result
  end

end
