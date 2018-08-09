class DeclareConvictionsPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:convictions, "#declare_convictions_form_declared_convictions_true", visible: false)
  element(:no_convictions, "#declare_convictions_form_declared_convictions_false", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Has anyone involved in')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    wait_for_heading
    find("label", text: (args[:answer])).click if args.key?(:answer)
    submit_button.click
  end

end
