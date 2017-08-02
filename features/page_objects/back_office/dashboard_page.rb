require_relative "sections/application_workflow_section"
require_relative "sections/masthead_section"

class DashboardPage < SitePrism::Page

  element :dashboard_selector, "#dashboardSelectorLink"

  element :application_name, "#FormTitle"
  element :form_selector, "#formselectorcontainer"
  element :add_application_btn, "img[Title='Add Application record.']"

  section(:mast_head, MastheadSection, MastheadSection::SELECTOR)

end
