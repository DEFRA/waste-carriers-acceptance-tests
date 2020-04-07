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

def visit_registration_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office_renewals']}/bo/registrations/#{reg_identifier}")
end

def visit_renewal_details_page(reg_identifier)
  visit("#{Quke::Quke.config.custom['urls']['back_office_renewals']}/bo/renewing-registrations/#{reg_identifier}")
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

def sign_in_to_back_office(user)
  # Check whether user is already logged in by visiting root page:
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")

  # Return if already logged in as that user.
  # This relies on the user property name in .config.yml being the same as the start of the user's email address:
  return if page.text.include? "Signed in as " + user

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
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")
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
