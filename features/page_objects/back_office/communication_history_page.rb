require_relative "sections/govuk_banner"

class CommunicationHistoryPage < BasePage

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  sections :communication_logs, "table tbody tr" do
    element(:template_name, "td:nth-child(1)")
    element(:template_id, "td:nth-child(2)")
    element(:type, "td:nth-child(3)")
    element(:sent_to, "td:nth-child(4)")
    element(:sent_on, "td:nth-child(5)")
  end

  def log_details(sent_to)
    communication_logs.find { |log| log.sent_to.text == sent_to }
  end
end
