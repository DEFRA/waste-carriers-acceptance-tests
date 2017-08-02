class ManagementSystemPage < SitePrism::Page

  element(:emas, "#manSysECEco", visible: false)
  element(:iso14001, "#manSysISO14001", visible: false)
  element(:bs8555, "#manSysBS8555", visible: false)
  element(:green_dragon, "#manSysGreenDragon", visible: false)
  element(:own_sytem, "#manSysOwnMeets", visible: false)

  element(:systems, "input[type='checkbox']", visible: false)

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    green_dragon.click
    submit_button.click
  end

end
