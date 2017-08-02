class OffencesCheckPage < SitePrism::Page

  # Details of the offence
  element(:offender_name, "#offencesDetailsName")
  element(:offender_position, "#organisation-position")
  element(:offence, "#offence-penalty")
  element(:dob_day, "#dob-day")
  element(:dob_month, "#dob-month")
  element(:dob_year, "#dob-year")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    offender_name.set(args[:offender_name]) if args.key?(:offender_name)
    offender_position.set(args[:offender_position]) if args.key?(:offender_position)
    offence.set(args[:offence]) if args.key?(:offence)
    dob_day.set(args[:dob_day]) if args.key?(:dob_day)
    dob_month.set(args[:dob_month]) if args.key?(:dob_month)
    dob_year.set(args[:dob_year]) if args.key?(:dob_year)

    submit_button.click
  end

end
