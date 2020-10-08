# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class OldApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONTEND AND BACKEND SPECIFIC PAGES
  # /

  def admin_sign_in_page
    @last_page = AdminSignInPage.new
  end

  def agency_sign_in_page
    @last_page = AgencySignInPage.new
  end

  def agency_users_page
    @last_page = AgencyUsersPage.new
  end

  def backend_registrations_page
    @last_page = BackendRegistrationsPage.new
  end

  def business_details_page
    @last_page = BusinessDetailsPage.new
  end

  def check_details_page
    @last_page = CheckDetailsPage.new
  end

  def confirm_account_page
    @last_page = ConfirmAccountPage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def construction_waste_question_page
    @last_page = ConstructionWasteQuestionPage.new
  end

  def finish_assisted_page
    @last_page = FinishAssistedPage.new
  end

  def frontend_sign_in_page
    @last_page = FrontendSignInPage.new
  end

  def key_people_page
    @last_page = KeyPeoplePage.new
  end

  def offline_payment_page
    @last_page = OfflinePaymentPage.new
  end

  def old_business_type_page
    @last_page = OldBusinessTypePage.new
  end

  def old_confirmation_page
    @last_page = OldConfirmationPage.new
  end

  def old_existing_registration_page
    @last_page = OldExistingRegistrationPage.new
  end

  def old_order_page
    @last_page = OldOrderPage.new
  end

  def old_start_page
    @last_page = OldStartPage.new
  end

  def only_deal_with_question_page
    @last_page = OnlyDealWithQuestionPage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def payments_page
    @last_page = PaymentsPage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
  end

  def registration_export_page
    @last_page = RegistrationExportPage.new
  end

  def registration_search_results_page
    @last_page = RegistrationSearchResultsPage.new
  end

  def registration_sign_in_page
    @last_page = RegistrationSignInPage.new
  end

  def registration_type_page
    # for carrier type
    @last_page = RegistrationTypePage.new
  end

  def relevant_people_page
    @last_page = RelevantPeoplePage.new
  end

  def relevant_convictions_page
    @last_page = RelevantConvictionsPage.new
  end

  def service_provided_question_page
    @last_page = ServiceProvidedQuestionPage.new
  end

  def sign_up_page
    @last_page = SignupPage.new
  end

end
