class RegistrationSearchResultsPage < SitePrism::Page

  #

  element(:export_all, "#export_btn")

  element(:submit_button, "#approveButton")

  sections :registrations, "table tbody tr" do
    element :registration_number, "td:nth-child(1)"
    element :company_name, "td:nth-child(2)"
    element :status, "td:nth-child(37)"
  end

  def registration(registration_number)
    registrations.each do |registration|
      if registration.registration_number.text == registration_number
        return registration
      end
    end
    nil
  end

end
