class SitePostCodePage < SitePrism::Page

  # What's the postcode for the site?
  element(:post_code, "#postcode")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    post_code.set(args[:post_code]) if args.key?(:post_code)
    submit_button.click
  end

end
