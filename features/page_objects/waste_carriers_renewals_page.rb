class WasteCarrierRenewalsPage < SitePrism::Page

  sections :user_registrations, "table tbody tr" do
    element(:renew_registration, "td:nth-child(3)")
  end

end
