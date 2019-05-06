# frozen_string_literal: true

class WorldpayTestSimulatorPage < SitePrism::Page

  element(:acquirer_responses, "select[name='PaRes']")
  element(:cvc_responses, "select[name='CVCRes']")
  element(:avs_responses, "select[name='AVSRes']")

  element(:continue, "input[name='continue']")

  def submit(_args = {})
    continue.click
  end

end
