class ConvictionsBoDetailsPage < SitePrism::Page

  # Back office user views conviction details for an existing registration or renewal

  element(:heading, "h1")
  element(:content, ".column-two-thirds")

  # Panel containing summary text on the convictions:
  element(:info_panel, ".panel")
  # Possible text in info panel:
  # This registration may have matching or declared convictions and requires an initial review.
  # This registration has been reviewed and flagged as having relevant convictions.
  # This registration was approved after a review of the matching or declared convictions.

  element(:approve_button, "[href$='/approve']")
  element(:flag_button, "[href$='/begin-checks']")
  element(:reject_button, "[href$='/reject']")

end
