# Represents all pages in the front office. Was created to avoid needing to
# create individual instances of each page throughout the steps.
# https://github.com/natritmeyer/site_prism#epilogue
class FrontOfficeApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  # FRONT OFFICE SPECIFIC PAGES
  # /
  def start_page
    @last_page = StartPage.new
  end

  def business_type_page
    @last_page = BusinessTypePage.new
  end

  def other_businesses_question_page
    @last_page = OtherBusinessesQuestionPage.new
  end

  def only_deal_with_question_page
    @last_page = OnlyDealWithQuestion.new
  end

  def business_details_page
    @last_page = BusinessDetailsPage.new
  end

  def contact_details_page
    @last_page = ContactDetailsPage.new
  end

  def postal_address_page
    @last_page = PostalAddressPage.new
  end

end
# rubocop:enable Metrics/ClassLength
