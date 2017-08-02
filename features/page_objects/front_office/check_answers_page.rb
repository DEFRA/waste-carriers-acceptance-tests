class CheckAnswersPage < SitePrism::Page

  # Check your answers before sending your application

  # Before you apply
  element(:change_read_rules, "a[href$='read-rules/index']")

  # Prepare to apply
  element(:change_find_out_what_you_need, "a[href$='what-need-to-apply']")
  element(:_change_pre_app_discussion, "a[href$='preapp-discussion']")

  # Complete application
  element(:change_contact_details, "a[href$='contact-details']")
  element(:change_site_operator, "a[href$='site-operator']")
  element(:change_operator_address, "a[href$='check-company-details']")
  element(:change_offences_statement, "a[href$='declare-offences']")
  element(:change_bankruptcy_statement, "a[href$='bankruptcy-insolvency']")
  element(:change_site_name, "a[href$='site-name']")
  element(:change_grid_ref, "a[href$='grid-reference']")
  element(:change_site_address, "a[href$='address']")
  element(:change_site_plan, "a[href$='upload-site-plan']")
  element(:change_qualifications, "a[href$='industry-scheme']")
  element(:change_management_system, "a[href$='management-system']")
  element(:change_confidentiality, "a[href$='claim-confidentiality']")

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    submit_button.click
  end

end
