# frozen_string_literal: true

def add_submitted_registration(registration, load_root_page = true)
  @world.registration_journey.start_page.load if load_root_page

  @world.registration_journey.start_page.submit(start_option: :new_registration)
  @world.registration_journey.location_page.submit(location: :england)
  @world.registration_journey.business_type_page.submit(business_type: registration[:business_type])

  complete_lower_tier_journey(registration) if registration[:business_type] == :charity
end

def complete_lower_tier_journey(registration)
  @world.registration_journey.business_details_page.submit(registration[:operator])
  @world.registration_journey.contact_details_page.submit(registration[:contact], current_url_is_internal?)
  @world.registration_journey.contact_address_page.submit()
  @world.registration_journey.check_details_page.submit()

  complete_sign_up_page(registration) unless current_url_is_internal?

  @world.registration_journey.confirmation_page.registration_number.text if current_url_is_internal?
end

def complete_sign_up_page(registration)
  @world.registration_journey.sign_up_page.submit(
    confirm_email: registration[:contact][:email],
    password: @world.default_password,
    confirm_password: @world.default_password
  )
end
