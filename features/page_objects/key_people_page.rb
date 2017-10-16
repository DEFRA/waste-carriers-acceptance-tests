class KeyPeoplePage < SitePrism::Page

  element(:first_name, "input[name='key_person[first_name]']")
  element(:last_name, "input[name='key_person[last_name]']")
  element(:dob_day, "input[name='key_person[dob_day]']")
  element(:dob_month, "input[name='key_person[dob_month]']")
  element(:dob_year, "input[name='key_person[dob_year]']")

  element(:add_key_person, "input[value='Add another director']")

  element(:submit_button, "input[value='Continue']")

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/CyclomaticComplexity
  # rubocop:disable Metrics/PerceivedComplexity
  def submit_directors(args = {})
    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    dob_day.set(args[:dob_day]) if args.key?(:dob_day)
    dob_month.set(args[:dob_month]) if args.key?(:dob_month)
    dob_year.set(args[:dob_year]) if args.key?(:dob_year)

    add_key_person.click

    first_name.set(args[:first_name]) if args.key?(:first_name)
    last_name.set(args[:last_name]) if args.key?(:last_name)
    dob_day.set(args[:dob_day]) if args.key?(:dob_day)
    dob_month.set(args[:dob_month]) if args.key?(:dob_month)
    dob_year.set(args[:dob_year]) if args.key?(:dob_year)

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
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/CyclomaticComplexity
  # rubocop:enable Metrics/PerceivedComplexity
end
