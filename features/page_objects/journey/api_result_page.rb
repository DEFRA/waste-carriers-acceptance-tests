# frozen_string_literal: true

require "json"

class ApiResultPage < SitePrism::Page
  # This is a wrapper page around JSON API results

  element(:json_data, "pre")

  def extract_data
    JSON.parse(json_data.text)
  end
end
