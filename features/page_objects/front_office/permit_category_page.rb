class PermitCategoryPage < SitePrism::Page

  # What do you want the permit for?
  elements(:permit_categories, "input[name='chosenCategory']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    if args.key?(:permit_categories)
      permit_categories.find { |btn| btn.value == args[:permit_categories] }.click
    end

    submit_button.click
  end

end
