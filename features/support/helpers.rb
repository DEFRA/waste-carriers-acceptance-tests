# Scroll to any element/section
# @param element [Capybara::Node::Element, SitePrism::Section]
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

def submit_valid_card_payment
  expect(@journey_app.worldpay_payment_page.test_mode_text).to have_text("Test Mode - This is not a live transaction")
  @journey_app.worldpay_payment_page.submit(
    card_number: "6759649826438453",
    cardholder_name: "3d.authorised",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555"
  )
  verify_cardholder if @journey_app.worldpay_payment_page.has_verification_heading?
end

def submit_invalid_card_payment
  expect(@journey_app.worldpay_payment_page.test_mode_text).to have_text("Test Mode - This is not a live transaction")
  @journey_app.worldpay_payment_page.submit(
    card_number: "6759649826438453",
    cardholder_name: "3d.refused",
    expiry_month: "12",
    expiry_year: next_year,
    security_code: "555"
  )
end

def verify_cardholder
  @journey_app.worldpay_payment_page.verify(response: "Cardholder authenticated")
end
