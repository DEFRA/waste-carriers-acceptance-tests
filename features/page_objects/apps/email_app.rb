# frozen_string_literal: true

# https://github.com/natritmeyer/site_prism#epilogue
class EmailApp
  # Using an attr_reader automatically gives us a my_app.last_page method
  attr_reader :last_page

  def last_email_page
    @last_page = LastEmailPage.new
  end

end
