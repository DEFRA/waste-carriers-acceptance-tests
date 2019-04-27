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
