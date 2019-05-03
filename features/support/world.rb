# frozen_string_literal: true

class World

  attr_reader :renewal_journey, :registration_journey, :email
  attr_reader :bo, :backend, :frontend
  attr_reader :backend_users
  attr_accessor :current_reg, :backend_user
  attr_accessor :last_email, :last_reference

  def initialize
    @renewal_journey = RenewalJourneyApp.new
    @registration_journey = RegistrationJourneyApp.new
    @bo = BackOfficeApp.new
    @backend = BackendApp.new
    @frontend = FrontendApp.new
    @email = EmailApp.new

    @backend_users = []
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

  def add_backend_user(email, type)
    @backend_users.push(
      email: email,
      type: type
    )
  end

  def remove_backend_user(email)
    result = @backend_users.select { |user| user[:email] == email }.first
    @backend_users.delete(result)
  end

  def select_backend_users(email: nil, type: nil)
    @backend_users.select do |user|
      next user[:email] == email if email
      next user[:type] == type if type

      true
    end
  end

end
