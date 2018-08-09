class WasteCarrierRenewalsPage < SitePrism::Page

  sections :registrations, "table tbody tr" do
    element(:registration_number, "td:nth-child(1)")
    element(:renew_registration, "td:nth-child(6)")
  end

  element(:heading, :xpath, "//*[normalize-space()='Listing Registrations']")
  element(:first_registration, "tr:nth-child(1) a")

  def registration(registration_number)
    registrations.each do |registration|
      return registration if registration.registration_number.text == registration_number
    end
    nil
  end

end
