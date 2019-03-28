# frozen_string_literal: true

def login_backend_user(user_email)
  @world.backend.agency_sign_in_page.load

  @world.backend.agency_sign_in_page.submit(
    email: user_email,
    password: @world.default_password
  )
end
