# frozen_string_literal: true

# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

# rubocop:disable Metrics/ClassLength
class BackendApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def agency_sign_in_page
    @last_page = AgencySignInPage.new
  end

  def admin_sign_in_page
    @last_page = AdminSignInPage.new
  end

  def dashboard_page
    @last_page = BackendDashboardPage.new
  end

  def new_users_page
    @last_page = NewUsersPage.new
  end

  def users_page
    @last_page = UsersPage.new
  end
end
