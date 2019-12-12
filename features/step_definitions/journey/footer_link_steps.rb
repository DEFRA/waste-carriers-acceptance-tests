Then("I can access the footer links") do
  new_window = window_opened_by { find_link("Privacy").click }
  within_window new_window do
    expect(@journey.standard_page.heading).to have_text("Waste carriers, brokers and dealers privacy policy")
    expect(@journey.standard_page.content).to have_text("Lower-tier registrations are non-expiring")
    new_window = window_opened_by { find_link("Cookies").click }
    within_window new_window do
      expect(@journey.standard_page.heading).to have_text("Cookies")
      expect(@journey.standard_page.content).to have_text("After 20 minutes of inactivity")
      new_window = window_opened_by { find_link("Accessibility").click }
      within_window new_window do
        expect(@journey.standard_page.heading).to have_text("Accessibility statement")
        expect(@journey.standard_page.content).to have_text("beta banner has insufficient contrast")
      end
    end
  end
end
