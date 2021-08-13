require_relative "sections/govuk_banner"

class ToggleFeaturesPage < SitePrism::Page

  section(:govuk_banner, GovukBanner, GovukBanner::SELECTOR)
  element(:heading, "h1")
  element(:content, "#main-content")

  element(:new_toggle_button, "a[href*='/feature-toggles/new']")
  element(:toggle_name, "#feature_toggle_key")
  element(:toggle_active_checkbox, "#feature_toggle_active", visible: false)
  element(:save_button, "input[value='Save']")

  element(:toggle_button, "input[value='Toggle']")

  def add_new_toggle(name)
    # Input toggle name as text. Toggle will be added if it doesn't exist already.
    # List of toggles: https://github.com/DEFRA/waste-carriers-back-office/blob/main/config/feature_toggles.yml
    return if content.text.include?(name)

    new_toggle_button.click
    toggle_name.set(name)
    toggle_active_checkbox.click
    save_button.click
  end

  def add_all_toggles
    add_new_toggle("new_registration")
    add_new_toggle("api")
    add_new_toggle("renewal_reminders")
    add_new_toggle("use_extended_grace_window")
  end

  def disable_feature(name)
    # Assuming that the toggle has been added, this disables the feature if not already disabled.
    table_row = find("tr", text: name)
    return if table_row.text.include?("DISABLED")

    within(table_row) do
      toggle_button.click
    end
  end

  def disable_all_features
    disable_feature("new_registration")
    disable_feature("api")
    disable_feature("renewal_reminders")
    disable_feature("use_extended_grace_window")
  end

  def enable_feature(name)
    # Assuming that the toggle has been added, this enables the feature if not already enabled.
    table_row = find("tr", text: name)
    return if table_row.text.include?("ENABLED")

    within(table_row) do
      toggle_button.click
    end
  end

  def enable_all_features
    enable_feature("new_registration")
    enable_feature("api")
    enable_feature("renewal_reminders")
    enable_feature("use_extended_grace_window")
  end

end
