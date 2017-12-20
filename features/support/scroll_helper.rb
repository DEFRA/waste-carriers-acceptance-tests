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
