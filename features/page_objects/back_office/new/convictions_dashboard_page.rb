require_relative "sections/govuk_banner.rb"

class ConvictionsDashboardPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)

  element(:heading, ".heading-large")
  element(:content, "#content")

  element(:possible_matches_tab, "a[href$='/convictions']")
  element(:in_progress_tab, "a[href*='/convictions/in-progress']")
  element(:approved_tab, "a[href*='/convictions/approved']")
  element(:rejected_tab, "a[href*='/convictions/rejected']")

  def look_for_text(text)
    # Look for the relevant text on page. If it's not there, click Next and look again.
    30.times do
      break if content.has_text?(text)

      find_link("Next ›").click
    end
  end

end
