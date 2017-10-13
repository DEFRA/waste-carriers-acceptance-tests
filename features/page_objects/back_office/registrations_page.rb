class RegistrationsPage < SitePrism::Page

  # Registration search
  element(:new_registration, "#new_registration")
  element(:search_input, "#q")
  element(:search, "#reg-search")
  element(:signout, "#signout_button")

  def search(args = {})
    search_input.set(args[:search_input]) if args.key?(:search_input)
    search.click
  end

end
