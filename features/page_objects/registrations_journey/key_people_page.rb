# frozen_string_literal: true

class KeyPeoplePage < SitePrism::Page

  element(:first_name, "#key_person_first_name")
  element(:last_name, "#key_person_last_name")
  element(:dob_day, "#key_person_dob_day")
  element(:dob_month, "#key_person_dob_month")
  element(:dob_year, "#key_person_dob_year")

  element(:add_person, "#add_btn")

  elements :remove_person, "a[href*='delete']"

  element(:submit_button, "#continue")

  def submit(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    dob_day.set(args[:day]) if args.key?(:day)
    dob_month.set(args[:month]) if args.key?(:month)
    dob_year.set(args[:year]) if args.key?(:year)

    submit_button.click
  end

  def add_key_person(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    dob_day.set(args[:day]) if args.key?(:day)
    dob_month.set(args[:month]) if args.key?(:month)
    dob_year.set(args[:year]) if args.key?(:year)

    add_person.click
  end
end
