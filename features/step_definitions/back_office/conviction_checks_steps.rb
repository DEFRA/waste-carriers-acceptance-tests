When(/^the conviction check is immediately approved by an NCCC user$/) do
  approve_conviction_immediately_for_reg(@reg_number, @business_name)

  @reg_type = :registration if @reg_type == :renewal
end

When(/^the conviction check is flagged by an NCCC user$/) do
  flag_conviction_for_reg(@reg_number, @business_name)
end

When(/^the flagged conviction is approved by an NCCC user$/) do
  approve_flagged_conviction_for_reg(@reg_number, @business_name)
end

When(/^the flagged conviction is rejected by an NCCC user$/) do
  reject_flagged_conviction_for_reg(@reg_number, @business_name)
end
