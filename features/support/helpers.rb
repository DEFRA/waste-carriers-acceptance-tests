# Scroll to any element/section
# @param element [Capybara::Node::Element, SitePrism::Section]

def load_all_apps
  @back_app = BackEndApp.new
  @bo = BackOfficeApp.new
  @journey = JourneyApp.new
  @renewals_app = RenewalsApp.new
end

def sign_in_to_back_office(user)
  visit((Quke::Quke.config.custom["urls"]["back_office_renewals"]) + "/bo")
  heading = @journey.standard_page.heading.text

  # Bypass if already logged in:
  return unless heading == "Sign in"

  @bo.sign_in_page.submit(
    # user must match the user headings in .config.yml
    email: Quke::Quke.config.custom["accounts"][user]["username"],
    password: ENV["WCRS_DEFAULT_PASSWORD"]
  )
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
  @email_address = rand(100_000_000).to_s + "@mailinator.com"
end

def next_year
  time = Time.new
  time.year + 1
end
