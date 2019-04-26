# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
# rubocop:disable Metrics/ClassLength
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # /

  def agency_users_sign_in_page
    @last_page = SignInPage.new
  end

  def business_address_page
    @last_page = BusinessAddressPage.new
  end

  def business_details_page
    @last_page = BusinessDetailsPage.new
  end

  def business_type_page
    @last_page = BusinessTypePage.new
  end

  def confirm_delete_page
    @last_page = ConfirmDeletePage.new
  end

  def contact_address_page
    @last_page = ContactAddressPage.new
  end

  def contact_name_page
    @last_page = ContactNamePage.new
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

  def confirmation_page
    @last_page = ConfirmationPage.new
  end

  def construction_waste_question_page
    @last_page = ConstructionWasteQuestionPage.new
  end

  def confirm_account_page
    @last_page = ConfirmAccountPage.new
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

  def location_page
    @last_page = LocationPage.new
  end

  def no_registration_page
    @last_page = NoRegistrationPage.new
  end

  def offline_payment_page
    @last_page = OfflinePaymentPage.new
  end

  def order_page
    @last_page = OrderPage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def only_deal_with_question_page
    @last_page = OnlyDealWithQuestionPage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
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

  def start_page
    @last_page = StartPage.new
  end

  def service_provided_question_page
    @last_page = ServiceProvidedQuestionPage.new
  end

  def sign_up_page
    @last_page = SignupPage.new
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

  def worldpay_card_choice_page
    @last_page = WorldpayCardChoicePage.new
  end

  def worldpay_card_details_page
    @last_page = WorldpayCardDetailsPage.new
  end

  def view_certificate_page
    @last_page = ViewCertificatePage.new
  end

  def view_pdf_certificate_page
    @last_page = ViewPdfCertificatePage.new
  end

end
# rubocop:enable Metrics/ClassLength
