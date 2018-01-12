# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class RenewalsApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # RENEWAL SPECIFIC PAGES
  # /

  def business_address_page
    @last_page = BusinessAddressPage.new
  end

  def business_type_page
    @last_page = BusinessTypePage.new
  end

  def cannot_renew_lower_tier_page
    @last_page = CannotRenewLowerTierPage.new
  end

  def cannot_renew_type_change_page
    @last_page = CannotRenewTypeChangePage.new
  end

  def check_your_answers_page
    @last_page = CheckYourAnswersPage.new
  end

  def correspondence_contact_name_page
    @last_page = CorrespondenceContactNamePage.new
  end

  def correspondence_contact_telephone_page
    @last_page = CorrespondenceContactTelephonePage.new
  end

  def contact_telephone_number_page
    @last_page = ContactTelephoneNumberPage.new
  end

  def contact_address_page
    @last_page = ContactAddressPage.new
  end

  def contact_email_page
    @last_page = ContactEmailPage.new
  end

  def company_name_page
    @last_page = CompanyNamePage.new
  end

  def contact_name_page
    @last_page = ContactNamePage.new
  end

  def declaration_page
    @last_page = DeclarationPage.new
  end

  def existing_registration_page
    @last_page = ExistingRegistrationPage.new
  end

  def key_people_page
    @last_page = KeyPeoplePage.new
  end

  def registration_number_page
    @last_page = RegistrationNumberPage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def payment_summary_page
    @last_page = PaymentSummaryPage.new
  end

  def post_code_page
    @last_page = PostCodePage.new
  end

  def registration_type_page
    @last_page = RegistrationTypePage.new
  end

  def relevant_convictions_page
    @last_page = RelevantConvictionsPage.new
  end

  def relevant_people_page
    @last_page = RelevantPeoplePage.new
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

  def start_page
    @last_page = StartPage.new
  end

  def waste_carriers_renewals_page
    @last_page = WasteCarrierRenewalsPage.new
  end

  def waste_carriers_renewals_sign_in_page
    @last_page = WasteCarrierRenewalsSignInPage.new
  end

  def worldpay_card_choice_page
    @last_page = WorldpayCardChoicePage.new
  end

  def worldpay_card_details_page
    @last_page = WorldpayCardDetailsPage.new
  end

end
# rubocop:enable Metrics/ClassLength
