class WasteCarrierRegistrationsPage < SitePrism::Page

  sections :user_registrations, ".grid-2-3 > div:nth-child(1) > table:nth-child(6)" do
    element(:edit_registration, "table>tbody>tr:nth-child(2) >td:nth-child(2)")
    element(:renew_registration, "table>tbody>tr:nth-child(2) >td:nth-child(3)")
  end

  elements(:edits, "[href*='/edit']")
  element(:sign_out, "#signout_button")

  def edit(args = {})
    if args.key?(:reg)
      search_val = "edit_#{args[:reg]}"
      edits.find { |chk| chk["id"] == search_val }.click
    end
  end

end
