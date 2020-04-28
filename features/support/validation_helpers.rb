# frozen_string_literal: true

def test_journey_validations(reg, reg_type)
  # This function tests error validations for the 'new registration' or 'renewal' journey
  # for 'reg', which is a hash containing a full set of registration data.
  # It runs from the applicant details to the end of the journey.
  # reg_type is "new" or "renew". For renewals, most fields are prepopulated.
  # If those prepopulated fields are radio buttons, a user can't generate an error.
  # It is split into small functions to help reuse and keep Rubocop happy.
end
