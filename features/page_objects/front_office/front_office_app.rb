# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # This app will become redundant when we get rid of accounts
  # /

  def front_office_sign_in_page
    @last_page = FrontOfficeSignInPage.new
  end

  def reset_password_page
    @last_page = ResetPasswordPage.new
  end

  def waste_carrier_registrations_page
    @last_page = WasteCarrierRegistrationsPage.new
  end

end
