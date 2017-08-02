class SiteNamePage < SitePrism::Page

  # What's the site name?
  element(:site_name, "#siteName")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    site_name.set(args[:site_name]) if args.key?(:site_name)
    submit_button.click
  end

end
