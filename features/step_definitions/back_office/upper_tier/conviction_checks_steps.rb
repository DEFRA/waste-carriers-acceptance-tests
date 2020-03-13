When(/^the conviction check is immediately approved by an agency user$/) do
  approve_conviction_immediately_for_reg(@reg_number, @business_name)
end

When(/^the conviction check is flagged by an agency user$/) do
  flag_conviction_for_reg(@reg_number, @business_name)
end

When(/^the flagged conviction is approved by an agency user$/) do
  approve_flagged_conviction_for_reg(@reg_number, @business_name)
end

When(/^the flagged conviction is rejected by an agency user$/) do
  reject_flagged_conviction_for_reg(@reg_number, @business_name)
end
