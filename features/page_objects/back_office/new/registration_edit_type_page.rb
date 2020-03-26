class RegistrationEditTypePage < SitePrism::Page
  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:carrier_dealer_radio, "#cbd_type_form_registration_type_carrier_dealer", visible: false)
  element(:broker_dealer_radio, "#cbd_type_form_registration_type_broker_dealer", visible: false)
  element(:carrier_broker_dealer_radio, "#cbd_type_form_registration_type_carrier_broker_dealer", visible: false)

  element(:submit_form, "input[type='submit']")
end
