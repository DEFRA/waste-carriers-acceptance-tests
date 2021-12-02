require "faker"

class ConvictionDetailsPage < BasePage

  # Details of the person with a conviction

  element(:first_name, "#conviction-details-form-first-name-field")
  element(:last_name, "#conviction-details-form-last-name-field")
  element(:dob_day, "#conviction-details-form-dob-day-field")
  element(:dob_month, "#conviction-details-form-dob-month-field")
  element(:dob_year, "#conviction-details-form-dob-year-field")
  element(:position, "#conviction-details-form-position-field")

  element(:add_person, "input[value='Add another person']")

  elements(:remove_person, "a[href*='delete']")
  element(:submit_button, "button[type='submit']")
  def add_conviction(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])
    position.set(person[:position])

    add_person.click
  end

  def submit(args = {})
    person = args[:person]

    first_name.set(person[:first_name])
    last_name.set(person[:last_name])
    dob_day.set(person[:dob_day])
    dob_month.set(person[:dob_month])
    dob_year.set(person[:dob_year])
    position.set(person[:position])

    submit_button.click
  end

  # rubocop:disable Layout/LineLength
  def main_people
    [
      { first_name: "Jane", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: "Fred", last_name: "Blogs", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" },
      { first_name: "Alex", last_name: "Smith-Brown", dob_day: 1, dob_month: 5, dob_year: 1984, position: "Head honcho" }
    ]
  end
  # rubocop:enable Layout/LineLength
end
