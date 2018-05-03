class WasteCarrierRegistrationsPage < SitePrism::Page

  sections :user_registrations, ".grid-2-3 > div:nth-child(1) > table:nth-child(6)" do
    element(:edit_registration, "table>tbody>tr:nth-child(2) >td:nth-child(2)")
    element(:renew_registration, "table>tbody>tr:nth-child(2) >td:nth-child(3)")
  end

  element(:sign_out, "#signout_button")

end
