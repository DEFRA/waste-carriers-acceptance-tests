class TaskListPage < SitePrism::Page

  element(:select_different_permit, "a[href$='selectpermit/choose-expanding-sections']")

  # Before you apply
  element(:cost_and_time, "#cost-and-time .task-name")
  element(:cost_and_time_completed_status, "#cost-and-time-completed")
  element(:read_rules, "#operation-rules .task-name")
  element(:read_rules_completed_status, "#operation-rules-complete")

  # Prepare to apply
  element(:find_out_what_you_need, "#what-you-need .task-name")
  element(:find_out_what_you_need_completed_status, "#what-you-need-complete")
  element(:pre_app_discussion, "#preapp .task-name")
  element(:pre_app_discussion_completed_status, "#preapp-completed")

  # Complete application
  element(:contact_details, "#contact-details .task-name")
  element(:contact_details_completed_status, "#contact-details-completed")
  element(:permit_holder_details, "#site-operator .task-name")
  element(:permit_holder_details_completed_status, "#site-operator-completed")
  element(:site_name_and_location, "#site-name .task-name")
  element(:site_name_and_location_completed_status, "#site-name-completed")
  element(:site_plan, "#site-plan .task-name")
  element(:site_plan_completed_status, "#site-plan-completed")
  element(:qualifications, "#industry-scheme .task-name")
  element(:qualifications_completed_status, "#industry-scheme-completed")
  element(:management_system, "#management-system .task-name")
  element(:management_system_completed_status, "#management-system-completed")
  element(:confidentiality_needs, "#confidentiality .task-name")
  element(:claim_confidentiality_completed_status, "#confidentiality-completed")

  element(:submit_button, "#submit-pay .task-name")

  def submit(_args = {})
    submit_button.click
  end

end
