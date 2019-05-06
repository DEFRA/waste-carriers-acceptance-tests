# frozen_string_literal: true

# Represents all pages in the frontend (excluding the registration journey).
# We use apps avoid needing to create individual instances of each page
# throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

class FrontendApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def existing_registration_page
    @last_page = ExistingRegistrationPage.new
  end

  def type_change_page
    @last_page = TypeChangePage.new
  end

  def waste_carrier_sign_in_page
    @last_page = WasteCarrierSignInPage.new
  end

  def waste_carrier_registrations_page
    @last_page = WasteCarrierRegistrationsPage.new
  end

  def view_certificate_page
    @last_page = ViewCertificatePage.new
  end

  def view_pdf_certificate_page
    @last_page = ViewPdfCertificatePage.new
  end

end
