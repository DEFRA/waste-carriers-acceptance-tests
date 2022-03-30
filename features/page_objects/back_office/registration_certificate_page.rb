class RegistrationCertificatePage < BasePage

  # PDF certificate rendered as HTML

  element(:content, ".grid-2-3")
  element(:heading, ".heading-small")

  def certificate_dates_are_correct(tier, resource_object)
    time = Time.new
    # The date in the certificate appears as a day (with no number padding) plus a month name, e.g. 1 April
    # See https://apidock.com/ruby/DateTime/strftime for syntax
    day_and_month = time.strftime("%-d") + " " + time.strftime("%B")
    expected_expiry_year = if resource_object == :renewal
                             time.year + 6
                           else
                             time.year + 3
                           end
    expiry_date_text = day_and_month + " " + expected_expiry_year.to_s

    if tier == :upper
      return true if content.text.include?(expiry_date_text)
    elsif content.text.include?("indefinitely")
      return true
    end
    puts "Certificate expiry date was incorrect"
    false
  end

end
