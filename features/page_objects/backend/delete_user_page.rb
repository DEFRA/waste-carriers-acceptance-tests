# frozen_string_literal: true

class DeleteUserPage < SitePrism::Page

  element(:submit_button, "#delete_agency_user")

  def submit(_args = {})
    submit_button.click
  end

end
