class ConvictionsPage < SitePrism::Page

  element(:approve, "a[href$='/approve']")
  element(:reject, "a[href$='/reject']")

end
