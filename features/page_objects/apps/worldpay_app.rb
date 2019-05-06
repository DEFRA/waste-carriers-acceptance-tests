# frozen_string_literal: true

# Represents all pages in the frontend (excluding the registration journey).
# We use apps avoid needing to create individual instances of each page
# throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue

class WorldpayApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def worldpay_card_choice_page
    @last_page = WorldpayCardChoicePage.new
  end

  def worldpay_card_details_page
    @last_page = WorldpayCardDetailsPage.new
  end

  def worldpay_refunds_page
    @last_page = WorldpayRefundsPage.new
  end

  def worldpay_secure_page
    @last_page = WorldpaySecurePage.new
  end

  def worldpay_test_simulator_page
    @last_page = WorldpayTestSimulatorPage.new
  end

end
