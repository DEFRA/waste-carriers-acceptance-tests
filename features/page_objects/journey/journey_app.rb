# Represents all shared pages across front and back office, or registrations and renewals.
# Aim to move as many pages as poss to journey, to avoid repetition and increase maintainability.

class JourneyApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def address_lookup_page
    @last_page = AddressLookupPage.new
  end

  def address_manual_page
    @last_page = AddressManualPage.new
  end

  def cards_confirmation_page
    @last_page = CardsConfirmationPage.new
  end

  def cards_order_page
    @last_page = CardsOrderPage.new
  end

  def cards_payment_page
    @last_page = CardsPaymentPage.new
  end

  def carrier_type_page
    @last_page = CarrierTypePage.new
  end

  def check_your_answers_page
    @last_page = CheckYourAnswersPage.new
  end

  def company_name_page
    @last_page = CompanyNamePage.new
  end

  def company_number_page
    @last_page = CompanyNumberPage.new
  end

  def company_people_page
    @last_page = CompanyPeoplePage.new
  end

  def confirm_business_type_page
    @last_page = ConfirmBusinessTypePage.new
  end

  def contact_email_page
    @last_page = ContactEmailPage.new
  end

  def contact_name_page
    @last_page = ContactNamePage.new
  end

  def contact_phone_page
    @last_page = ContactPhonePage.new
  end

  def conviction_declare_page
    @last_page = ConvictionDeclarePage.new
  end

  def conviction_details_page
    @last_page = ConvictionDetailsPage.new
  end

  def declaration_page
    @last_page = DeclarationPage.new
  end

  def standard_page
    @last_page = StandardPage.new
  end

  def tier_check_page
    @last_page = TierCheckPage.new
  end

  def tier_construction_waste_page
    @last_page = TierConstructionWastePage.new
  end

  def tier_farm_only_page
    @last_page = TierFarmOnlyPage.new
  end

  def tier_other_businesses_page
    @last_page = TierOtherBusinessesPage.new
  end

  def tier_service_provided_page
    @last_page = TierServiceProvidedPage.new
  end

  def worldpay_payment_page
    @last_page = WorldpayPaymentPage.new
  end

end
