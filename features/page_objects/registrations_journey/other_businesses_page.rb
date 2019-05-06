# frozen_string_literal: true

class OtherBusinessesPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_option, "#registration_otherBusinesses_yes", visible: true)
  element(:no_option, "#registration_otherBusinesses_no", visible: true)

  element(:submit_button, "#continue")

  def submit(args = {})
    case args[:choice]
    when :no
      no_option.click
    when :yes
      yes_option.click
    end
    submit_button.click
  end

end
