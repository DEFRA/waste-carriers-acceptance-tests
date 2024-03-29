# Represents all pages in the back office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

class BackOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page, :base_page

  # BACK OFFICE SPECIFIC PAGES
  # /

  def ad_privacy_policy_page
    @last_page = AdPrivacyPolicyPage.new
  end

  def cease_or_revoke_page
    @last_page = CeaseOrRevokePage.new
  end

  def restore_page
    @last_page = RestorePage.new
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

  def communication_history_page
    @last_page = CommunicationHistoryPage.new
  end

  def dashboard_page
    @last_page = DashboardPage.new
  end

  def edit_confirm_cancel_page
    @last_page = EditConfirmCancelPage.new
  end

  def edit_page
    @last_page = EditPage.new
  end

  def finance_charge_adjust_input_page
    @last_page = FinanceChargeAdjustInputPage.new
  end

  def finance_charge_adjust_select_page
    @last_page = FinanceChargeAdjustSelectPage.new
  end

  def finance_payment_details_page
    @last_page = FinancePaymentDetailsPage.new
  end

  def finance_payment_input_page
    @last_page = FinancePaymentInputPage.new
  end

  def finance_payment_method_page
    @last_page = FinancePaymentMethodPage.new
  end

  def finance_refund_select_page
    @last_page = FinanceRefundSelectPage.new
  end

  def finance_reversal_input_page
    @last_page = FinanceReversalInputPage.new
  end

  def finance_reversal_select_page
    @last_page = FinanceReversalSelectPage.new
  end

  def finance_writeoff_page
    @last_page = FinanceWriteoffPage.new
  end

  def registration_certificate_page
    @last_page = RegistrationCertificatePage.new
  end

  def registration_details_page
    @last_page = RegistrationDetailsPage.new
  end

  def sign_in_page
    @last_page = SignInPage.new
  end

  def toggle_features_page
    @last_page = ToggleFeaturesPage.new
  end

  def transfer_registration_page
    @last_page = TransferRegistrationPage.new
  end

  def user_invite_page
    @last_page = UserInvitePage.new
  end

  def user_migrate_page
    @last_page = UserMigratePage.new
  end

  def users_page
    @last_page = UsersPage.new
  end

end
