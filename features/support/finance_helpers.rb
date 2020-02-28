# Functions that can be reused to help with finance

def sign_in_as_appropriate_finance_user(method)
  # Select user with appropriate permissions for the payment method:
  user = if %w[cash cheque postal].include? method
           "agency_user_with_payment_refund"
         elsif method == "transfer"
           "finance_basic"
         else
           "finance_admin"
         end

  sign_out_of_back_office
  sign_in_to_back_office(user)
end

def pay_by_cash(amount_in_pounds)
  @bo.finance_payment_method_page.submit(choice: :cash)
  @bo.finance_payment_input_page.submit(
    amount: amount_in_pounds.to_s,
    day: "01",
    month: "01",
    year: "1980",
    reference: "0101010",
    comment: "cash money"
  )
end

def check_balance(expected_balance)
  @bo.registration_details_page.payment_details_link.click

  # Get the balance from the payment details page, assuming it is the last text on the page.

  # The regex searches for: any number of digits . two more digits newline Open Government Licence
  # See https://www.rubyguides.com/2015/06/ruby-regex/
  balance_on_page = page.text[/(-?\d+\.\d+)\nOpen Government Licence/, 1].to_f
  expect(balance_on_page).to eq(expected_balance.to_f)
end

def go_to_payments_page(reg)
  # Find the payment details for the registration/renewal:
  if @is_transient_renewal == true
    @bo.dashboard_page.view_transient_reg_details(search_term: reg)
  else
    @bo.dashboard_page.view_reg_details(search_term: reg)
  end
  @bo.registration_details_page.payment_details_link.click
  expect(@bo.finance_payment_details_page.heading).to have_text("Payment details for " + reg)
end

def enter_payment(amount, method)
  # This assumes a user with finance permission is logged in and on the payments page.
  # Amount can be a string or number.
  # List of method options is in finance_payment_method_page.rb

  @bo.finance_payment_details_page.enter_payment_button.click
  @bo.finance_payment_method_page.submit(choice: method.to_sym)
  expect(@bo.finance_payment_input_page.heading).to have_text("payment for " + @reg_number)
  time = Time.new
  @bo.finance_payment_input_page.submit(
    amount: amount.to_s,
    day: time.strftime("%d"),
    month: time.strftime("%m"),
    year: time.year,
    reference: method,
    comment: "Automated " + method + " payment for £" + amount.to_s
  )
end

def check_payment_confirmation_message(amount)
  expect(@bo.finance_payment_details_page.flash_message).to have_text("£" + amount.to_s + " payment entered successfully")
end

def adjust_charge(amount, random_number)
  # Start from payments page and add a positive or negative charge
  @bo.finance_payment_details_page.charge_adjust_button.click
  expect(@bo.finance_charge_adjust_select_page.heading).to have_text("Make a charge adjustment for " + @reg_number)
  submit_option = amount >= 0 ? :positive : :negative
  @bo.finance_charge_adjust_select_page.submit(choice: submit_option)

  # Enter charge adjust details
  amount = amount.abs
  @bo.finance_charge_adjust_input_page.submit(
    amount: amount.to_s,
    reference: "autoadjust",
    reason: submit_option.to_s + " charge adjustment " + random_number.to_s
  )
end

def reverse_last_transaction
  # Start from payments page and reverse the last transaction available to that user (according to their permissions)
  @bo.finance_payment_details_page.reverse_payment_button.click
  expect(@bo.finance_reversal_select_page.heading).to have_text("Which payment do you want to reverse?")
  @bo.finance_reversal_select_page.reverse_links.last.click
  expect(@bo.finance_reversal_input_page.heading).to have_text("Reverse a payment for " + @reg_number)
  @bo.finance_reversal_input_page.submit(reason: "ti esrever")
end

def write_off_outstanding_balance
  # Start from payments page and write off whatever balance is outstanding.
  # It assumes the currently logged in user has permission to write off the amount.
  @bo.finance_payment_details_page.write_off_button.click
  expect(@bo.finance_writeoff_page.heading).to have_text("Write off a difference for " + @reg_number)
  @bo.finance_writeoff_page.submit(reason: "this is a writeoff")
end
