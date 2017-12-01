class PostCodePage < SitePrism::Page

  # whats the registered address of the company?

  element(:post_code, "#address_postcode")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    post_code.set(args[:post_code]) if args.key?(:post_code)

    submit_button.click
  end

end
