class ViewCertificatePage < SitePrism::Page

  # Certificate of Registration under the Waste (England and Wales) Regulations 2011
  elements(:view_cert_in_pdf, "[href*='/view.pdf']")

end
