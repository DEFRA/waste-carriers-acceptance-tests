class WasteCarrierRenewalsPage < SitePrism::Page

  sections :user_registrations, "table tbody tr" do
  	element(:registration_number, "td:nth-child(1)")
    element(:renew_registration, "td:nth-child(6)")
  end

end
