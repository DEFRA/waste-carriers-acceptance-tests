# Represents all shared pages across front and back office.
# Aim to move as many pages as poss to journey, to avoid repetition and increase maintainability.

class JourneyApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # PAGES SHARED BETWEEN FRONT AND BACK OFFICE

  def address_lookup_page
    @last_page = AddressLookupPage.new
  end

  def address_manual_page
    @last_page = AddressManualPage.new
  end

  def worldpay_payment_page
    @last_page = WorldpayPaymentPage.new
  end

end
