# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

class JourneyApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # PAGES SHARED BETWEEN FRONT AND BACK OFFICE

  def worldpay_payment_page
    @last_page = WorldpayPaymentPage.new
  end

end
