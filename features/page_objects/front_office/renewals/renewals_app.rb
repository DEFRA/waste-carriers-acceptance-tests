# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class RenewalsApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # RENEWAL SPECIFIC PAGES
  # /

  def cannot_renew_lower_tier_page
    @last_page = CannotRenewLowerTierPage.new
  end

  def cannot_renew_type_change_page
    @last_page = CannotRenewTypeChangePage.new
  end

  def renewal_information_page
    @last_page = RenewalInformationPage.new
  end

  def renewal_start_page
    @last_page = RenewalStartPage.new
  end

  def renewal_received_page
    @last_page = RenewalReceivedPage.new
  end

  def unrenewable_page
    @last_page = UnrenewablePage.new
  end

  def waste_carrier_sign_in_page
    @last_page = WasteCarrierSignInPage.new
  end

  def waste_types_page
    @last_page = WasteTypesPage.new
  end

  def waste_carriers_renewals_sign_in_page
    @last_page = WasteCarrierRenewalsSignInPage.new
  end

  def waste_carrier_registrations_page
    @last_page = WasteCarrierRegistrationsPage.new
  end

end
