class ConvictionsBoDetailsPage < SitePrism::Page

  # Back office user views conviction details for an existing registration or renewal

  element(:heading, ".heading-large")
  element(:content, ".column-two-thirds")

  # Panel containing summary text on the convictions:
  element(:info_panel, ".panel")
  # Possible text in info panel:
  # This registration may have matching or declared convictions and requires an initial review.
  # This registration has been reviewed and flagged as having relevant convictions.
  # This registration was approved after a review of the matching or declared convictions.

  element(:approve_button, ".button", text: "Approve")
  element(:flag_button, ".button-alert", text: "Relevant conviction found")
  element(:reject_button, ".button-warning", text: "Reject")

end
