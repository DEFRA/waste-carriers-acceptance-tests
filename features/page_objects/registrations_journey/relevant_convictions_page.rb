# frozen_string_literal: true

class RelevantConvictionsPage < SitePrism::Page

  # Has anyone involved in managing your organisation been convicted
  # of an environmental offence in the last 12 months?
  element(:yes, "#registration_declaredConvictions_yes", visible: false)
  element(:no, "#registration_declaredConvictions_no", visible: false)

  element(:submit_button, "#continue")

  def submit(args = {})
    # As long as the arg passed in matches the name of an element we can simply
    # invoke the element using ruby's send() method. In this way we can avoid
    # overly long case/switch statements that check the value of the arg to
    # determine which element to select
    send(args[:choice]).select_option

    submit_button.click
  end

end
