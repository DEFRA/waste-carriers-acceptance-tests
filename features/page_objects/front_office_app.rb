# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # /
  def start_page
    @last_page = StartPage.new
  end

  def waste_carrier_sign_in_page
    @last_page = WasteCarrierSignInPage.new
  end

  def business_type_page
    @last_page = BusinessTypePage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def only_deal_with_question_page
    @last_page = OnlyDealWithQuestionPage.new
  end

  def construction_waste_question_page
    @last_page = ConstructionWasteQuestionPage.new
  end

  def service_provided_question_page
    @last_page = ServiceProvidedQuestionPage.new
  end

  def business_details_page
    @last_page = BusinessDetailsPage.new
  end

  def check_details_page
    @last_page = CheckDetailsPage.new
  end

  def company_name_page
    @last_page = CompanyNamePage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def contact_address_page
    @last_page = ContactAddresPage.new
  end

  def correspondence_contact_name_page
    @last_page = CorrespondenceContactNamePage.new
  end

  def correspondence_contact_telephone_page
    @last_page = CorrespondenceContactTelephonePage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
  end

  def post_code_page
    @last_page = PostCodePage.new
  end

  def declaration_page
    @last_page = DeclarationPage.new
  end

  def sign_up_page
    @last_page = SignupPage.new
  end

  def agency_users_sign_in_page
    @last_page = SignInPage.new
  end

  def confirm_account_page
    @last_page = ConfirmAccountPage.new
  end

  def registration_type_page
    @last_page = RegistrationTypePage.new
  end

  def key_people_page
    @last_page = KeyPeoplePage.new
  end

  def relevant_convictions_page
    @last_page = RelevantConvictionsPage.new
  end

  def order_page
    @last_page = OrderPage.new
  end

  def worldpay_card_choice_page
    @last_page = WorldpayCardChoicePage.new
  end

  def worldpay_card_details_page
    @last_page = WorldpayCardDetailsPage.new
  end

  def offline_payment_page
    @last_page = OfflinePaymentPage.new
  end

  def registration_confirmed_page
    @last_page = RegistrationConfirmedPage.new
  end

  def no_registration_page
    @last_page = NoRegistrationPage.new
  end

  def mailinator_page
    @last_page = MailinatorPage.new
  end

  def mailinator_inbox_page
    @last_page = MailinatorInboxPage.new
  end

  def mailinator_email_details_page
    @last_page = MailinatorEmailDetailsPage.new
  end

  def waste_carrier_registrations_page
    @last_page = WasteCarrierRegistrationsPage.new
  end

  def relevant_people_page
    @last_page = RelevantPeoplePage.new
  end

  def existing_registration_page
    @last_page = ExistingRegistrationPage.new
  end

  def renewal_start_page
    @last_page = RenewalStartPage.new
  end

  def type_change_page
    @last_page = TypeChangePage.new
  end

  def renewal_information_page
    @last_page = RenewalInformationPage.new
  end

  def limited_company_number_page
    @last_page = LimitedCompanyNumberPage.new
  end

  def generate_email
    @email = "wastecarrier" + rand(100_000_000).to_s + "@mailinator.com"
  end

end
# rubocop:enable Metrics/ClassLength
