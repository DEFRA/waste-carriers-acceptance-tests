# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
# rubocop:disable Metrics/ClassLength
class BackEndApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page
  # BACK OFFICE SPECIFIC PAGES
  # /

  def agency_sign_in_page
    @last_page = AgencySignInPage.new
  end

  def agency_users_page
    @last_page = AgencyUsersPage.new
  end

  def admin_sign_in_page
    @last_page = AdminSignInPage.new
  end

  def business_details_page
    @last_page = BusinessDetailsPage.new
  end

  def business_address_page
    @last_page = BusinessAddressPage.new
  end

  def business_type_page
    @last_page = BusinessTypePage.new
  end

  def carrier_type_page
    @last_page = CarrierTypePage.new
  end

  def check_details_page
    @last_page = CheckDetailsPage.new
  end

  def company_name_page
    @last_page = CompanyNamePage.new
  end

  def company_number_page
    @last_page = RegistrationNumberPage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def construction_waste_question_page
    @last_page = ConstructionWasteQuestionPage.new
  end

  def contact_telephone_number_page
    @last_page = ContactTelephoneNumberPage.new
  end

  # Pages such as these are actually defined in front_app:
  def contact_address_page
    @last_page = ContactAddressPage.new
  end

  def contact_manual_address_page
    @last_page = ContactManualAddressPage.new
  end

  def contact_email_page
    @last_page = ContactEmailPage.new
  end

  def contact_name_page
    @last_page = ContactNamePage.new
  end

  def contact_postcode_page
    @last_page = ContactPostCodePage.new
  end

  def declare_convictions_page
    @last_page = DeclareConvictionsPage.new
  end

  def declaration_page
    @last_page = DeclarationPage.new
  end

  def edit_account_email_page
    @last_page = EditAccountEmailPage.new
  end

  def finish_assisted_page
    @last_page = FinishAssistedPage.new
  end

  def key_people_page
    @last_page = KeyPeoplePage.new
  end

  def location_page
    @last_page = LocationPage.new
  end

  def manual_address_page
    @last_page = ManualAddressPage.new
  end

  def migrate_page
    @last_page = MigratePage.new
  end

  def offline_payment_page
    @last_page = OfflinePaymentPage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def only_deal_with_question_page
    @last_page = OnlyDealWithQuestionPage.new
  end

  def order_page
    @last_page = OrderPage.new
  end

  def payment_summary_page
    @last_page = PaymentSummaryPage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
  end

  def post_code_page
    @last_page = PostCodePage.new
  end

  def registration_export_page
    @last_page = RegistrationExportPage.new
  end

  def registration_search_results_page
    @last_page = RegistrationSearchResultsPage.new
  end

  def registrations_page
    @last_page = RegistrationsPage.new
  end

  def registration_type_page
    @last_page = RegistrationTypePage.new
  end

  def relevant_people_page
    @last_page = RelevantPeoplePage.new
  end

  def relevant_convictions_page
    @last_page = RelevantConvictionsPage.new
  end

  def renewal_information_page
    @last_page = RenewalInformationPage.new
  end

  def renewal_received_page
    @last_page = RenewalReceivedPage.new
  end

  def renewal_complete_page
    @last_page = RenewalCompletePage.new
  end

  def renewal_start_page
    @last_page = RenewalStartPage.new
  end

  def start_page
    @last_page = StartPage.new
  end

  def service_provided_question_page
    @last_page = ServiceProvidedQuestionPage.new
  end

  def sign_up_page
    @last_page = SignupPage.new
  end

  def sign_in_page
    @last_page = SignInPage.new
  end

  def users_page
    @last_page = UsersPage.new
  end

end
# rubocop:enable Metrics/ClassLength
