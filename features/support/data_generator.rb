# frozen_string_literal: true

require "faker"

def generate_registration(business_type, operator_name = nil)
  contact = generate_person
  operator_name ||= generate_operator_name(business_type, "#{contact[:first_name]} #{contact[:last_name]}")

  {
    business_type: business_type,
    operator: generate_operator(business_type, operator_name),
    people: [generate_person, generate_person],
    contact: contact,
    card_details: generate_card_details(contact)
  }
end

def generate_operator(business_type, operator_name)
  data = {
    operator_name: operator_name,
    postcode: "BS1 5AH",
    result: "ENVIRONMENT AGENCY, HORIZON HOUSE, DEANERY ROAD, BRISTOL, BS1 5AH"
  }

  data[:registration_number] = "00445790" if business_type == :limited

  data
end

def generate_person
  first_name ||= Faker::Name.first_name
  last_name ||= Faker::Name.last_name

  {
    first_name: first_name,
    last_name: last_name,
    telephone: "0117 9000000",
    email: generate_example_email(first_name, last_name),
    day: generate_day_of_birth,
    month: generate_month_of_birth,
    year: generate_year_of_birth
  }
end

def dodgy_people
  [
    { first_name: "Jane", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984 },
    { first_name: "Fred", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984 },
    { first_name: "Alex", last_name: "Smith-Brown", dob_day: 1, dob_month: 5, dob_year: 1984 }
  ]
end

def generate_operator_name(business_type, operator_name)
  operator_name = "#{Faker::Company.name} Ltd" if business_type == :limited
  operator_name
end

def generate_example_email(first_name, last_name)
  first_name ||= Faker::Name.first_name
  last_name ||= Faker::Name.last_name

  "#{first_name.downcase}.#{last_name.downcase}#{rand(1..999)}@example.com".delete("'")
end

def generate_day_of_birth
  rand(1..28)
end

def generate_month_of_birth
  rand(1..12)
end

def generate_year_of_birth
  rand(1960..2001)
end

# Test credit card details

# Card numbers
# @mastercard_number = "5100080000000000"
# @visacard_number = "4917610000000000"
# @maestrocard_number = "6759649826438453"

# Card holder names
# @authorised = "3d.authorised"
# @refused = "3d.refused"
# @error = "3d.error"

# Security codes (CSV)
# @approved = "555"
# @failed = "444"
def generate_card_details(person)
  {
    type: :mastercard,
    number: "4444333322221111",
    security_code: "123",
    holder_name: "#{person[:first_name]} #{person[:last_name]}",
    expiry_month: "12",
    expiry_year: Time.new.year + 2
  }
end
