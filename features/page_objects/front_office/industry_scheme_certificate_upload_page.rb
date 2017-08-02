class IndustrySchemeCertificateUploadPage < SitePrism::Page

  element(:submit_button, "input[type='Submit']")

  def submit(_args = {})
    # Capybara attach file method
    attach_file("upload", File.absolute_path("./features/support/test.pdf"))

    submit_button.click
  end

end
