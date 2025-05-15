Given("the govPay payment status is {string}") do |status|
    visit_govPay_mock_payment_status_page(status)
end

Given("the govPay refund status is {string}") do |status|
    visit_govPay_mock_refund_status_page(status)
end
