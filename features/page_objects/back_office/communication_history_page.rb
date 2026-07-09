require_relative "sections/govuk_banner"

class CommunicationHistoryPage < BasePage

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  sections :communication_logs, "table tbody tr" do
    element(:template_title, "td:nth-child(1)")
    element(:type, "td:nth-child(2)")
    element(:sent_on, "td:nth-child(3)")
    element(:delivery_status, "td:nth-child(4)")
  end

  def log_details(template_title)
    communication_logs.find { |log| log.template_title.text == template_title }
  end
end
