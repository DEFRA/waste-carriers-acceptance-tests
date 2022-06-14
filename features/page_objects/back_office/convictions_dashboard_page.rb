require_relative "sections/govuk_banner"

class ConvictionsDashboardPage < BasePage

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:possible_matches_tab, "a[href$='/convictions']")
  element(:in_progress_tab, "a[href*='/convictions/in-progress']")
  element(:approved_tab, "a[href*='/convictions/approved']")
  element(:rejected_tab, "a[href*='/convictions/rejected']")
  element(:next_link, "a[aria-label='Next page']")

  def look_for_text(text)
    # Look for the relevant text on page. If it's not there, click Next and look again.
    30.times do
      break if content.has_text?(text)

      next_link.click
    end
  end

end
