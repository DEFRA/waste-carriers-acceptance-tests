require_relative "sections/govuk_banner.rb"

class InviteUserPage < SitePrism::Page
  set_url "#{Quke::Quke.config.custom["urls"]["back_office_renewals"]}/bo/users/invitation/new"

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element :email_field, 'input[name="user[email]"]'
  element :submit_form, 'input[type="submit"]'

  element :agency_user_radio, 'input[value="agency"]', visible: false
  # element :agency_user_with_refund_radio, '#user_role_agency_with_refund'
  # element :agency_super_user_radio, '#user_role_agency_super'
  # element :developer_user_radio, '#user_role_developer'
end
