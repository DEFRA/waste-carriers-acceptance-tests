# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # This app will become redundant when we get rid of accounts
  # /
  def certificate_confirm_email_page
    @last_page = CertificateConfirmEmailPage.new
  end

  def reset_password_page
    @last_page = ResetPasswordPage.new
  end

  def front_office_dashboard
    @last_page = FrontOfficeDashboard.new
  end

  def deregistration_confirmation_page
    @last_page = DeregistrationConfirmationPage.new
  end

  def deregistration_complete_page
    @last_page = DeregistrationCompletePage.new
  end

  def unsubscription_confirmation_page
    @last_page = UnsubscribtionConfirmationPage.new
  end

end
