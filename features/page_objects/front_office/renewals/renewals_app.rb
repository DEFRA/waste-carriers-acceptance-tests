# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class RenewalsApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # RENEWAL SPECIFIC PAGES
  # /

  def bank_transfer_page
    @last_page = BankTransferPage.new
  end

  def cannot_renew_lower_tier_page
    @last_page = CannotRenewLowerTierPage.new
  end

  def cannot_renew_type_change_page
    @last_page = CannotRenewTypeChangePage.new
  end

  def construction_waste_page
    @last_page = ConstructionWastePage.new
  end

  def existing_registration_page
    @last_page = ExistingRegistrationPage.new
  end

  def location_page
    @last_page = LocationPage.new
  end

  def other_businesses_page
    @last_page = OtherBusinessesPage.new
  end

  def payment_summary_page
    @last_page = PaymentSummaryPage.new
  end

  def registration_cards_page
    @last_page = RegistrationCardsPage.new
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

  def renewal_complete_page
    @last_page = RenewalCompletePage.new
  end

  def service_provided_page
    @last_page = ServiceProvidedPage.new
  end

  def start_page
    @last_page = StartPage.new
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
