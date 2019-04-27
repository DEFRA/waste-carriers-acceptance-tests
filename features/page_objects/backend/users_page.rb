# frozen_string_literal: true

class UsersPage < SitePrism::Page

  set_url(join_url(Quke::Quke.config.custom["urls"]["backend"], "/agency_users"))

  element(:add_user, "#new_agency_user")
  element(:sign_out, "#signout_button")

  def edit_link(email)
    find("tr", text: email).find("a", text: "Edit")
  end

  def delete_link(email)
    find("tr", text: email).find("a", text: "Delete")
  end

end
