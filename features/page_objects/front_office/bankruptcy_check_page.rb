class BankruptcyCheckPage < SitePrism::Page

  # Are there any bankruptcy or insolvency proceedings involving a company or anyone connected to the application?
  element(:yes_bankruptcy_insolvency, "#yesBankruptcyInsolvency", visible: false)
  element(:no_bankruptcy_insolvency, "#noBankruptcyInsolvency", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    case args[:choice]
    when :no
      no_bankruptcy_insolvency.select_option
    when :offences
      yes_bankruptcy_insolvency.select_option
    end
    submit_button.click
  end

end
