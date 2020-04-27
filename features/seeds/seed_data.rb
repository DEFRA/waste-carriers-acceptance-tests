# This will seed data using files in the `fixtures` subfolder.
# Usage: SeedData.seed("complete_active_registration.json")
# It will return a reg_number newly generated to use in the test suite.
# Check REDME.md for more info

require "net/http"

class SeedData
  def self.seed(file_name)
    response = new(file_name).seed

    JSON.parse(response.body)["reg_identifier"]
  end

  def seed
    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = data
    response = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end

  private

  attr_reader :file_name

  def initialize(file_name)
    @file_name = file_name
  end

  def uri
    address = "#{Quke::Quke.config.custom['urls']['back_office']}/api/registrations"

    URI.parse(address)
  end

  def data
    path_to_data_file = File.join(__dir__, "fixtures", file_name)

    File.read(path_to_data_file)
  end
end
