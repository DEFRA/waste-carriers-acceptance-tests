# frozen_string_literal: true

class StandardPage < BasePage

  # This is a generic page object file used for simple, standard pages, to prevent adding lots of separate files

  def submit(_args = {})
    submit_button.click
  end

end
