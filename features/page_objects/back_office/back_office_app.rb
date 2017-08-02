# Represents all pages in the back office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class BackOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # / (when not signed in)
  def login_page
    @last_page = LoginPage.new
  end

  # Main dashboard iframe
  def dashboard_page
    @last_page = DashboardPage.new
  end

  # main application page
  def application_details_page
    @last_page = ApplicationDetailsPage.new
  end

end
