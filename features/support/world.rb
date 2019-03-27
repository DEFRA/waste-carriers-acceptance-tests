# frozen_string_literal: true

class World

  attr_reader :renewal_journey, :registration_journey, :bo, :email

  def initialize
    @renewal_journey = RenewalJourneyApp.new
    @registration_journey = RegistrationJourneyApp.new
    @bo = BackOfficeApp.new
    @email = EmailApp.new
  end

  agency_user:
      username: agency-user@wcr.gov.uk
    agency_user_with_payment_refund:
      username: agency-refund-payment-user@wcr.gov.uk
    finance_admin:
      username: finance-admin-user@wcr.gov.uk
    finance_basic:
      username: finance-user@wcr.gov.uk
    waste_carrier:
      username: user@example.com
    waste_carrier2:
      username: another-user@example.com
    agency_super:
      username: agency-super@wcr.gov.uk

  def agency_user
    Quke::Quke.config.custom["accounts"]["agency_user"]["username"]
  end

  def agency_with_payment_refund_user
    Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"]
  end

  def finance_admin_user
    Quke::Quke.config.custom["accounts"]["finance_admin"]["username"]
  end

  def finance_basic_user
    Quke::Quke.config.custom["accounts"]["finance_basic"]["username"]
  end

  def agency_super_user
    Quke::Quke.config.custom["accounts"]["agency_super"]["username"]
  end

  def default_password
    ENV["WCR_DEFAULT_PASSWORD"]
  end

  def external_url
    Quke::Quke.config.custom["urls"]["external"]
  end

  def internal_url
    Quke::Quke.config.custom["urls"]["internal"]
  end

  def mail_client_url
    Quke::Quke.config.custom["urls"]["mail_client"]
  end

end
