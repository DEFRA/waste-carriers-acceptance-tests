class CannotRenewLowerTierPage < SitePrism::Page

  # You cannot renew
  element(:new_registration, "a[href*='/registrations/start']")
  element(:heading, :xpath, "//h1[contains(text(), 'You')]")

end
