# frozen_string_literal: true

def login_backend_user(user_email)
  @world.backend.agency_sign_in_page.load

  @world.backend.agency_sign_in_page.submit(
    email: user_email,
    password: @world.default_password
  )
end

def login_backend_admin(user_email)
  @world.backend.admin_sign_in_page.load

  @world.backend.admin_sign_in_page.submit(
    email: user_email,
    password: @world.default_password
  )
end

def create_backend_user(email, load_root_page = true)
  @world.backend.users_page.load if load_root_page
  @world.backend.users_page.add_user.click
  @world.backend.new_users_page.submit(
    email: email,
    password: @world.default_password
  )

  @world.add_backend_user(email, :agency) if page.has_text?("Agency user was successfully created.")
end

def edit_backend_user(user = nil, load_root_page = true)
  @world.backend.users_page.load if load_root_page

  @world.backend_user = @world.select_backend_users(type: :agency).first unless user
  @world.backend.users_page.edit_link(@world.backend_user[:email]).click

  edited_email = "edited_#{@world.backend_user[:email]}"
  @world.backend.edit_user_page.submit(
    email: edited_email,
    password: @world.default_password
  )

  # Update our world with the last user and email details, but only if the edit
  # was successful
  if page.has_text?("Agency user was successfully updated.")
    @world.backend_user[:email] = edited_email
    @world.last_email = edited_email
  end
end

def delete_backend_user(user = nil, load_root_page = true)
  @world.backend.users_page.load if load_root_page

  user = @world.select_backend_users(type: :agency).first unless user
  @world.backend.users_page.delete_link(user[:email]).click
  @world.backend.delete_user_page.submit

  @world.remove_backend_user(user) if page.has_text?("Agency user was successfully deleted.")
end
