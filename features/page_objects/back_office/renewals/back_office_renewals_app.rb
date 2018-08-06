# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class BackOfficeRenewalsApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page
  # BACK OFFICE SPECIFIC PAGES
  # /
  def admin_sign_in_page
    @last_page = AdminSignInPage.new
  end

  def generate_email
    @email_address = "waste.carrier.service" + "+" + rand(100_000_000).to_s + "@gmail.com"
  end

end
# rubocop:enable Metrics/ClassLength
