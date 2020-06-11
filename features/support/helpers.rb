# Scroll to any element/section
# @param element [Capybara::Node::Element, SitePrism::Section]

require "facets"
require "pry"

def load_all_apps
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @renewals_app = RenewalsApp.new
end

def mocking_enabled?
  # Simple helper to check if mocking is currently enabled.
  # It is based on the fact that the mock gem uses URL constraints,
  # hence when we hit a mocking valid URL, if we receive a 404 response back,
  # we can assume that mocking is disabled
  uri = URI.parse(Quke::Quke.config.custom["urls"]["mock_enabled"])

  # using an instance variable so that we make the request to the mocking
  # endpoint only once
  @_mocking_enabled_response ||= Net::HTTP.get_response(uri)

  return false if @_mocking_enabled_response == "404"

  true
end

def sign_in_to_front_end_if_necessary(email)
  @renewals_app = RenewalsApp.new

  unless @renewals_app.waste_carriers_renewals_sign_in_page.displayed?
    @renewals_app.waste_carriers_renewals_sign_in_page.load
  end

  return if page.has_text?("Signed in as")

  @renewals_app.waste_carriers_renewals_sign_in_page.submit(
    email: email,
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

def sign_in_to_back_office(user, force = true)
  # If force == true then this forces signout regardless of the user's type.

  # Check whether user is already logged in by visiting root page:
  visit(Quke::Quke.config.custom["urls"]["back_office"])

  # Return if already logged in as that user.
  # This relies on the user property name in .config.yml being the same as the start of the user's email address:
  return if page.text.include?("Signed in as") && !force
  return if page.text.include? "Signed in as #{user}"

  # If user is already signed in as a different user, then sign them out:
  heading = @journey.standard_page.heading.text
  sign_out_of_back_office if heading != "Sign in"

  # Then sign in as the correct user:
  @bo.sign_in_page.submit(
    # user must match the user headings in .config.yml:
    email: Quke::Quke.config.custom["accounts"][user]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
end

def sign_out_of_back_office
  # Check not already signed out
  visit(Quke::Quke.config.custom["urls"]["back_office"])
  heading = @journey.standard_page.heading.text

  # Bypass if already logged out:
  return if heading != "Waste carriers registrations"

  @bo.dashboard_page.sign_out_link.click
  expect(@journey.standard_page.heading).to have_text("Sign in")
end

def scroll_to(element)
  element = element.root_element if element.respond_to?(:root_element)
  Capybara.evaluate_script <<-SCRIPT
       function() {
         var element = document.evaluate('#{element.path}', document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
         window.scrollTo(0, element.getBoundingClientRect().top + pageYOffset - 200);
       }();
  SCRIPT
end

def click(node)
  if Capybara.current_driver == :phantomjs
    node.trigger("click")
  else
    node.click
  end
end

def try(number_of_times)
  count = 0
  item_of_interest = nil
  until !item_of_interest.nil? || count == number_of_times
    item_of_interest = yield
    sleep 10
    count += 1
  end
end

def generate_email
  @email_address = "#{rand(100_000_000)}@example.com"
end

def look_into_paginated_content_for(text)
  # Start from first page. Look for the known text on page.
  # If it's not there, click Next and look again.
  # Break after 30 pages.
  find_link("« First").click if page.has_text?("« First")

  30.times do
    break if page.has_text?(text)

    find_link("Next ›").click
  end
end

def next_year
  time = Time.new
  time.year + 1
end

def retrieve_email_containing(search_terms)
  # Search for and return email text containing all the items from the search_terms array.
  # Assumes that the user has already navigated to the correct front or back office email page.
  email_was_found = @journey.last_email_page.check_email_for_text(search_terms)
  return @journey.last_email_page.text if email_was_found

  "Email not found"
end
