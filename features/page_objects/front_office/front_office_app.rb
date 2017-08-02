# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
# rubocop:disable Metrics/ClassLength
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # /
  def start_or_resume_page
    @last_page = StartOrResumePage.new
  end

  def save_choice_page
    @last_page = SaveChoicePage.new
  end

  def confirm_email_page
    @last_page = ConfirmEmailPage.new
  end

  def save_and_return_sent_page
    @last_page = SaveAndReturnSentPage.new
  end

  def permit_category_page
    @last_page = PermitCategoryPage.new
  end

  def select_permit_page
    @last_page = SelectPermitPage.new
  end

  def task_list_page
    @last_page = TaskListPage.new
  end

  def cost_and_time_page
    @last_page = CostAndTimePage.new
  end

  def read_rules_page
    @last_page = ReadRulesPage.new
  end

  def find_out_what_need_to_apply_page
    @last_page = FindOutWhatNeedToApplyPage.new
  end

  def pre_app_discussion_page
    @last_page = PreAppDiscussionPage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def site_operator_details_page
    @last_page = SiteOperatorDetailsPage.new
  end

  def check_operator_page
    @last_page = CheckOperatorPage.new
  end

  def check_company_details_page
    @last_page = CheckCompanyDetailsPage.new
  end

  def declare_offences_page
    @last_page = DeclareOffencesPage.new
  end

  def bankruptcy_check_page
    @last_page = BankruptcyCheckPage.new
  end

  def site_name_page
    @last_page = SiteNamePage.new
  end

  def grid_reference_page
    @last_page = GridReferencePage.new
  end

  def site_post_code_page
    @last_page = SitePostCodePage.new
  end

  def site_address_page
    @last_page = SiteAddressPage.new
  end

  def site_plan_page
    @last_page = SitePlanPage.new
  end

  def industry_scheme_page
    @last_page = IndustrySchemePage.new
  end

  def industry_scheme_certificate_upload_page
    @last_page = IndustrySchemeCertificateUploadPage.new
  end

  def industry_scheme_check_your_answers_page
    @last_page = IndustrySchemeCheckYourAnswersPage.new
  end

  def management_system_page
    @last_page = ManagementSystemPage.new
  end

  def claim_confidentiality_page
    @last_page = ClaimConfidentialityPage.new
  end

  def check_answers_page
    @last_page = CheckAnswersPage.new
  end

  def payment_method_page
    @last_page = PaymentMethodPage.new
  end

  def how_to_pay_page
    @last_page = HowToPayPage.new
  end

  def application_sent_page
    @last_page = ApplicationSentPage.new
  end

  def offences_check_page
    @last_page = OffencesCheckPage.new
  end

  def confirm_payment_page
    @last_page = ConfirmPaymentPage.new
  end

  def card_payment_page
    @last_page = CardPaymentPage.new
  end

end
# rubocop:enable Metrics/ClassLength
