require "faker"

class CompanyPeoplePage < BasePage

  element(:first_name, "#main-people-form-first-name-field")
  element(:last_name, "#main-people-form-last-name-field")
  element(:dob_day, "#main-people-form-dob-day-field")
  element(:dob_month, "#main-people-form-dob-month-field")
  element(:dob_year, "#main-people-form-dob-year-field")
  element(:add_person, "input[value='Add another person']")
  elements(:remove_person, "input[value='Delete']")
  element(:submit_button, "button[type='submit']")

  def add_main_person(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])

    add_person.click
  end

  def submit_main_person(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])

    submit_button.click
  end

  def submit(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    dob_day.set(args[:dob_day]) if args.key?(:dob_day)
    dob_month.set(args[:dob_month]) if args.key?(:dob_month)
    dob_year.set(args[:dob_year]) if args.key?(:dob_year)

    submit_button.click
  end

  # rubocop:disable Layout/LineLength
  def main_people
    [
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984 }
    ]
  end
  # rubocop:enable Layout/LineLength
end
