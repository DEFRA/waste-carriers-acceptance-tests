class RegistrationCertificatePage < SitePrism::Page

  # PDF certificate rendered as HTML

  element(:content, ".grid-2-3")
  element(:heading, ".heading-small")

  def certificate_dates_are_correct(tier, resource_object)
    time = Time.new
    # The date in the certificate appears as a day (with no number padding) plus a month name, e.g. 1 April
    # See https://apidock.com/ruby/DateTime/strftime for syntax
    day_and_month = time.strftime("%-d") + " " + time.strftime("%B")
    start_date_text = day_and_month + " " + time.year.to_s
    expected_expiry_year = get_expected_expiry_year(time, resource_object)
    expiry_date_text = day_and_month + " " + expected_expiry_year.to_s

    if tier == "upper"
      return true if content.text.include?(start_date_text) && content.text.include?(expiry_date_text)
    elsif content.text.include?(start_date_text) && content.text.include?("indefinitely")
      return true
    end
    puts "Certificate dates were incorrect"
    false
  end

  def get_expected_expiry_year(time, resource_object)
    if resource_object == :renewal
      time.year + 6
    else
      time.year + 3
    end
  end

end
