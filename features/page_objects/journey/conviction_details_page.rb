require "faker"

class ConvictionDetailsPage < SitePrism::Page

  # Details of the person with a conviction

  element(:heading, ".heading-large")
  element(:first_name, "#conviction_details_form_first_name")
  element(:last_name, "#conviction_details_form_last_name")
  element(:dob_day, "#conviction_details_form_dob_day")
  element(:dob_month, "#conviction_details_form_dob_month")
  element(:dob_year, "#conviction_details_form_dob_year")
  element(:position, "#conviction_details_form_position")

  element(:add_person, "input[value='Add another person']")

  elements(:remove_person, "a[href*='delete']")

  element(:submit_button, "input[value='Continue']")

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
