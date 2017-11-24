class RenewalIntroductionPage < SitePrism::Page

  # You are about to renew

  element(:submit_button, "#continue")

  def submit(_args = {})
    submit_button.click
  end

end
