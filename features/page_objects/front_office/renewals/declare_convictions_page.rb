class DeclareConvictionsPage < SitePrism::Page

  # Do you ever deal with waste from other businesses or households?
  element(:convictions, "#declare_convictions_form_declared_convictions_yes", visible: false)
  element(:no_convictions, "#declare_convictions_form_declared_convictions_no", visible: false)
  element(:heading, :xpath, "//h1[contains(text(), 'Has anyone involved in')]")
  element(:submit_button, "input[type='submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_convictions.click
    when :yes
      convictions.click
    end
    submit_button.click
  end

end
