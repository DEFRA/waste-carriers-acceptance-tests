class SiteAddressPage < SitePrism::Page

  element(:show_list, "#the_address")
  element(:results_dropdown, "select#the_address")

  element(:submit_button, "input[value='Continue']")

  def submit(args = {})
    show_list.click
    sleep(1)
    results_dropdown.select(args[:result]) if args.key?(:result)

    submit_button.click
  end

end
