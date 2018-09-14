class TransientRegistrationsPage < SitePrism::Page

  element(:continue_as_assisted_digital, "a[href^='/bo/renew']")
  element(:process_payment, "a[href$='/payments']")

end
