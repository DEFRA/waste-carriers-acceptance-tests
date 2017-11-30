When(/^the limited company registration has the conviction check approved by an agency user$/) do
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq("Conviction Check")
  @back_app.registrations_page.search_results[0].approve.click
  expect(@back_app.approve_page.conviction_match_info.text).to have_text("Yes (company)")
  @back_app.approve_page.submit(approval_reason: "Company check pass")

end

When(/^the key person has the conviction check approved by an agency user$/) do
  @back_app.agency_sign_in_page.load
  @back_app.registrations_page.search(search_input: @registration_number)
  expect(@back_app.registrations_page.search_results[0].status.text).to eq("Conviction Check")
  @back_app.registrations_page.search_results[0].approve.click
  @back_app.approve_page.submit(approval_reason: "Key person check pass")
end

Then(/^the registration has a "([^"]*)" status$/) do |status|
  @back_app.registrations_page.search(search_input: @registration_number)
  sleep(1)
  refresh_cnt = 0
  loop do
    # puts "The reg status is #{@back_app.registrations_page.search_results[0].status.text}"
    if @back_app.registrations_page.search_results[0].status.text == status
      # puts "I found the status"
      refresh_cnt = 20
    else
      # reloads the page if service layer hasn't updated elastic search in time
      # puts "Status not found, gonna try refreshing"
      page.evaluate_script("window.location.reload()")
      refresh_cnt += 1
    end
    break unless refresh_cnt < 20
  end

  expect(@back_app.registrations_page.search_results[0].status.text).to eq(status)

end
