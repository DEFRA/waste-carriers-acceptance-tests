# frozen_string_literal: true

def add_submitted_registration(registration, load_root_page = true)
  @world.registration_journey.start_page.load if load_root_page

  @world.registration_journey.start_page.submit(start_option: :new_registration)
  @world.registration_journey.location_page.submit(location: :england)
  @world.registration_journey.business_type_page.submit(business_type: registration[:business_type])

  if registration[:business_type] == :charity
    complete_lower_tier_journey(registration)
    return
  end

  complete_smart_answers

  @world.registration_journey.registration_type_page.submit(choice: :carrier_broker_dealer)

  @world.registration_journey.business_details_page.submit(registration[:operator])
  @world.registration_journey.contact_details_page.submit(registration[:contact], current_url_is_internal?)
  @world.registration_journey.contact_address_page.submit()

  complete_key_people(registration)

  @world.registration_journey.relevant_convictions_page.submit(choice: :no)
  @world.registration_journey.check_details_page.submit(declaration: true)

  complete_sign_up_page(registration) unless current_url_is_internal?

  @world.registration_journey.order_page.submit(
    copy_card_number: "2",
    choice: :card_payment
  )
  @world.worldpay.worldpay_card_choice_page.submit(choice: registration[:card_details][:type])
  @world.worldpay.worldpay_card_details_page.submit(registration[:card_details])
  @world.worldpay.worldpay_test_simulator_page.submit
end

def complete_smart_answers
  @world.registration_journey.other_businesses_page.submit(choice: :no)
  @world.registration_journey.construction_waste_page.submit(choice: :yes)
end

def complete_key_people(registration)
  people = if registration[:business_type] == :individual
             [registration[:contact]]
           else
             registration[:people]
           end

  @world.registration_journey.key_people_page.submit(people[0])
  people.drop(1).each do |person|
    @world.registration_journey.key_people_page.add_person.click
    @world.registration_journey.key_people_page.submit(person)
  end
end

def complete_lower_tier_journey(registration)
  @world.registration_journey.business_details_page.submit(registration[:operator])
  @world.registration_journey.contact_details_page.submit(registration[:contact], current_url_is_internal?)
  @world.registration_journey.contact_address_page.submit()
  @world.registration_journey.check_details_page.submit(declaration: true)

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
