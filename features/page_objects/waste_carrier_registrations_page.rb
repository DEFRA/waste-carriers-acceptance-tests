class WasteCarrierRegistrationsPage < SitePrism::Page

  sections :user_registrations, ".grid-2-3 > div:nth-child(1) > table:nth-child(6)" do
    element(:edit_registration, "table>tbody>tr:nth-child(2) >td:nth-child(2)")
    element(:renew_registration, "table>tbody>tr:nth-child(2) >td:nth-child(3)")
    element(:delete, "table>tbody>tr:nth-child(2) >td:nth-child(5)")
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

end
