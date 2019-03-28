# frozen_string_literal: true

class BusinessTypePage < SitePrism::Page

  element(:individual, "#registration_businessType_soletrader")
  element(:partnership, "#registration_businessType_partnership")
  element(:limited, "#registration_businessType_limitedcompany")
  element(:public_body, "#registration_businessType_publicbody")
  element(:charity, "#registration_businessType_charity")
  element(:local_authority, "#registration_businessType_authority")
  element(:other, "#registration_businessType_other")

  element(:submit_button, "#continue")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:business_type]).select_option

    submit_button.click
  end

end
