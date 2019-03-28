# frozen_string_literal: true

# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

# rubocop:disable Metrics/ClassLength
class BackOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def agency_sign_in_page
    @last_page = AgencySignInPage.new
  end

  def agency_users_page
    @last_page = AgencyUsersPage.new
  end

  def approve_page
    @last_page = ApprovePage.new
  end

  def admin_sign_in_page
    @last_page = AdminSignInPage.new
  end

  def bank_transfer_page
    @last_page = BankTransferPage.new
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

  def cash_payment_page
    @last_page = CashPaymentPage.new
  end

  def charge_adjustments_page
    @last_page = ChargeAdjustmentsPage.new
  end

  def check_details_page
    @last_page = CheckDetailsPage.new
  end

  def check_your_answers_page
    @last_page = CheckYourAnswersPage.new
  end

  def confirmation_page
    @last_page = ConfirmationPage.new
  end

  def confirm_business_type_page
    @last_page = ConfirmBusinessTypePage.new
  end

  def confirm_delete_page
    @last_page = ConfirmDeletePage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def company_name_page
    @last_page = CompanyNamePage.new
  end

  def construction_waste_question_page
    @last_page = ConstructionWasteQuestionPage.new
  end

  def contact_telephone_number_page
    @last_page = ContactTelephoneNumberPage.new
  end

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

  def main_people_page
    @last_page = MainPeoplePage.new
  end

  def new_charge_adjustment_page
    @last_page = NewChargeAdjustmentPage.new
  end

  def new_reversal_page
    @last_page = NewReversalPage.new
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

  def payment_status_page
    @last_page = PaymentStatusPage.new
  end

  def payment_summary_page
    @last_page = PaymentSummaryPage.new
  end

  def payment_reversals_page
    @last_page = PaymentReversalsPage.new
  end

  def payments_page
    @last_page = PaymentsPage.new
  end

  def refunds_page
    @last_page = RefundsPage.new
  end

  def renewal_payments_page
    @last_page = RenewalPaymentsPage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
  end

  def post_code_page
    @last_page = PostCodePage.new
  end

  def registration_cards_page
    @last_page = RegistrationCardsPage.new
  end

  def registration_export_page
    @last_page = RegistrationExportPage.new
  end

  def registration_search_results_page
    @last_page = RegistrationSearchResultsPage.new
  end

  def registration_number_page
    @last_page = RegistrationNumberPage.new
  end

  def renewals_dashboard_page
    @last_page = RenewalsDashboardPage.new
  end

  def renewal_information_page
    @last_page = RenewalInformationPage.new
  end

  def relevant_people_page
    @last_page = RelevantPeoplePage.new
  end

  def relevant_convictions_page
    @last_page = RelevantConvictionsPage.new
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

  def registrations_page
    @last_page = RegistrationsPage.new
  end

  def registration_type_page
    @last_page = RegistrationTypePage.new
  end

  def transient_registrations_page
    @last_page = TransientRegistrationsPage.new
  end

  def refund_complete_page
    @last_page = RefundCompletePage.new
  end

  def revoke_page
    @last_page = RevokePage.new
  end

  def migrate_page
    @last_page = MigratePage.new
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

  def tier_check_page
    @last_page = TierCheckPage.new
  end

  def worldpay_card_choice_page
    @last_page = WorldpayCardChoicePage.new
  end

  def worldpay_card_details_page
    @last_page = WorldpayCardDetailsPage.new
  end

  def worldpay_refunds_page
    @last_page = WorldpayRefundsPage.new
  end

  def write_offs_page
    @last_page = WriteOffsPage.new
  end

  def users_page
    @last_page = UsersPage.new
  end

end
# rubocop:enable Metrics/ClassLength
