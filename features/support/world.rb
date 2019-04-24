# frozen_string_literal: true

class World

  attr_reader :renewal_journey, :registration_journey, :bo, :backend, :email
  attr_accessor :current_reg
  attr_accessor :last_email, :last_reference

  def initialize
    @renewal_journey = RenewalJourneyApp.new
    @registration_journey = RegistrationJourneyApp.new
    @bo = BackOfficeApp.new
    @backend = BackendApp.new
    @email = EmailApp.new
  end

  def agency_super_user
    Quke::Quke.config.custom["accounts"]["agency_super"]["username"]
  end

  def agency_with_payment_refund_user
    Quke::Quke.config.custom["accounts"]["agency_user_with_payment_refund"]["username"]
  end

  def agency_user
    Quke::Quke.config.custom["accounts"]["agency_user"]["username"]
  end

  def finance_super_user
    Quke::Quke.config.custom["accounts"]["finance_super"]["username"]
  end

  def finance_admin_user
    Quke::Quke.config.custom["accounts"]["finance_admin"]["username"]
  end

  def finance_user
    Quke::Quke.config.custom["accounts"]["finance_user"]["username"]
  end

  def default_password
    ENV["WCR_DEFAULT_PASSWORD"]
  end

  def frontend_url
    Quke::Quke.config.custom["urls"]["frontend"]
  end

  def backend_url
    Quke::Quke.config.custom["urls"]["backend"]
  end

  def front_office_url
    Quke::Quke.config.custom["urls"]["front_office"]
  end

  def back_office_url
    Quke::Quke.config.custom["urls"]["back_office"]
  end

  def mail_client_url
    Quke::Quke.config.custom["urls"]["mail_client"]
  end

end
