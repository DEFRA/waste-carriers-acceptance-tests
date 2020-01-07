# Represents all pages in the back office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

# rubocop:disable Metrics/ClassLength
class BackOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # BACK OFFICE SPECIFIC PAGES
  # /

  def ad_privacy_policy_page
    @last_page = AdPrivacyPolicyPage.new
  end

  def agency_sign_in_page
    @last_page = AgencySignInPage.new
  end

  def bank_transfer_page
    @last_page = BankTransferPage.new
  end

  def cash_payment_page
    @last_page = CashPaymentPage.new
  end

  def cease_or_revoke_page
    @last_page = CeaseOrRevokePage.new
  end

  def convictions_bo_details_page
    @last_page = ConvictionsBoDetailsPage.new
  end

  def convictions_dashboard_page
    @last_page = ConvictionsDashboardPage.new
  end

  def convictions_decision_page
    @last_page = ConvictionsDecisionPage.new
  end

  def cannot_renew_lower_tier_page
    @last_page = CannotRenewLowerTierPage.new
  end

  def cannot_renew_type_change_page
    @last_page = CannotRenewTypeChangePage.new
  end

  def dashboard_page
    @last_page = DashboardPage.new
  end

  def existing_registration_page
    @last_page = ExistingRegistrationPage.new
  end

  def finance_payments_page
    @last_page = FinancePaymentsPage.new
  end

  def finish_assisted_page
    @last_page = FinishAssistedPage.new
  end

  def location_page
    @last_page = LocationPage.new
  end

  def migrate_page
    @last_page = MigratePage.new
  end

  def payments_page
    @last_page = PaymentsPage.new
  end

  def payment_summary_page
    @last_page = PaymentSummaryPage.new
  end

  def registrations_page
    @last_page = RegistrationsPage.new
  end

  def registration_cards_page
    @last_page = RegistrationCardsPage.new
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

  def start_page
    @last_page = StartPage.new
  end

  def sign_in_page
    @last_page = SignInPage.new
  end

  def transfer_registration_page
    @last_page = TransferRegistrationPage.new
  end

  def transient_registrations_page
    @last_page = TransientRegistrationsPage.new
  end

  def users_page
    @last_page = UsersPage.new
  end

  def unrenewable_page
    @last_page = UnrenewablePage.new
  end

  def view_details_page
    @last_page = ViewDetailsPage.new
  end

  def waste_carrier_sign_in_page
    @last_page = WasteCarrierSignInPage.new
  end

  def waste_types_page
    @last_page = WasteTypesPage.new
  end

  def waste_carrier_registrations_page
    @last_page = WasteCarrierRegistrationsPage.new
  end

end
# rubocop:enable Metrics/ClassLength
