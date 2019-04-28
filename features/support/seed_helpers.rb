# frozen_string_literal: true

def seed_backend_users
  login_backend_admin(@world.agency_super_user)

  # We know we need at least 2 backend users; one for a delete scenario and
  # one for an edit scenario
  @world.last_email = generate_example_email(nil, nil)
  create_backend_user(@world.last_email, false)

  @world.last_email = generate_example_email(nil, nil)
  create_backend_user(@world.last_email, true)
end
