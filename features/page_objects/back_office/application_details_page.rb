require_relative "sections/application_workflow_section"
require_relative "sections/masthead_section"

class ApplicationDetailsPage < SitePrism::Page

  element(:heading, "h1[Title='New Application']")

  section(:mast_head, MastheadSection, MastheadSection::SELECTOR)
  section(:work_flow, ApplicationWorkflowSection, ApplicationWorkflowSection::SELECTOR)

end
