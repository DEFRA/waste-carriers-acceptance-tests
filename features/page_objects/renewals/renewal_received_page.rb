class RenewalReceivedPage < SitePrism::Page

  # Registration complete
  element(:heading, :xpath, "//h1[contains(text(), 'Application received')]")

end
