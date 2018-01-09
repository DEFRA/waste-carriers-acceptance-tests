class CannotRenewTypeChangePage < SitePrism::Page

  # You cannot renew
  element(:new_registration, "a[href*='/registrations/start']")

end
