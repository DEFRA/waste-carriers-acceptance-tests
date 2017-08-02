class GridReferencePage < SitePrism::Page

  # Whats the grid reference for the site?
  element(:grid_ref, "#grid-reference")

  element(:submit_button, "input[type='Submit']")

  def submit(args = {})
    grid_ref.set(args[:grid_ref]) if args.key?(:grid_ref)
    submit_button.click
  end

end
