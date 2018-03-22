class OtherBusinessesPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:yes_other_businesses, "#other_businesses_form_other_businesses_true", visible: false)
  element(:no_other_businesses, "#other_businesses_form_other_businesses_false", visible: false)

  element(:submit_button, "input[type='submit']")

  def submit(args = {})
  	wait_for_submit_button(5)
    find("label", text: (args[:answer])).click if args.key?(:answer)

    submit_button.click
  end

end
