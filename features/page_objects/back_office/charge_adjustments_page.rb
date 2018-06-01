class ChargeAdjustmentsPage < SitePrism::Page

  # Write off difference

  element(:add_charge, "input[name='positive_payment']")

  element(:add_negative_charge, "input[name='negative_payment']")

end
