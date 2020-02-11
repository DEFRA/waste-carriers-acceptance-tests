require "faker"

class RelevantPeoplePage < SitePrism::Page

  # Details of the person with a conviction

  element(:first_name, "#key_person_first_name")
  element(:last_name, "#key_person_last_name")
  element(:dob_day, "#key_person_dob_day")
  element(:dob_month, "#key_person_dob_month")
  element(:dob_year, "#key_person_dob_year")
  element(:position, "#key_person_position")

  element(:add_person, "#add_btn")

  elements :remove_person, "a[href*='delete']"

  element(:submit_button, "#continue")

  def add_relevant_person(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])
    position.set(person[:position])

    add_person.click
  end

  def submit_relevant_person(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])
    position.set(person[:position])

    submit_button.click
  end

  def submit(args = {})
    first_name.set(args[:first_name])
    last_name.set(args[:last_name])
    dob_day.set(args[:dob_day]) if args.key?(:dob_day)
    dob_month.set(args[:dob_month]) if args.key?(:dob_month)
    dob_year.set(args[:dob_year]) if args.key?(:dob_year)
    position.set(args[:position]) if args.key?(:position)

    submit_button.click
  end

  # rubocop:disable Layout/LineLength
  def relevant_people
    [
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" }
    ]
  end

  def dodgy_people
    [
      { first_name: "Jane", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: "Fred", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: "Alex", last_name: "Smith-Brown", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" }
    ]
  end
  # rubocop:enable Layout/LineLength
end
