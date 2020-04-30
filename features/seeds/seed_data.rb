# This will seed data using files in the `fixtures` subfolder.
# Usage: SeedData.seed("complete_active_registration.json")
# It will return a reg_number newly generated to use in the test suite.
# Check README.md for more info

require "net/http"

class SeedData
  def self.seed(file_name, options = {})
    response = new(file_name, options).seed

    JSON.parse(response.body)["reg_identifier"]
  end

  def seed
    request = Net::HTTP::Post.new(uri, "Content-Type" => "application/json")
    request.body = data

    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end

  private

  attr_reader :file_name, :options

  def initialize(file_name, options)
    @file_name = file_name
    @options = options
  end

  def uri
    address = "#{Quke::Quke.config.custom['urls']['back_office']}/api/registrations"

    URI.parse(address)
  end

  def data
    path_to_data_file = File.join(__dir__, "fixtures", file_name)

    data_content = File.read(path_to_data_file)

    # Manipulate the JSON from the json file using the options provided.
    # This allow for more flexibility and less JSON files to deal with.
    inflate_content(data_content)
  end

  def inflate_content(data)
    data = JSON.parse(data)

    inflate_copy_cards_order(data)
    recalculate_balances(data)

    data.to_json
  end

  def inflate_copy_cards_order(data)
    return unless options.key?(:copy_cards)

    order_item = {
      "amount" => 500 * options[:copy_cards].to_i,
      "currency" => "GBP",
      "description" => "Copy cards",
      "reference" => "",
      "type" => "COPY_CARDS"
    }

    order = data["financeDetails"]["orders"].first

    order["orderItems"] << order_item
  end

  def recalculate_balances(data)
    data["financeDetails"]["orders"].each do |order|
      order["totalAmount"] = order["orderItems"].sum { |item| item["amount"] }
    end

    total_all_orders = data["financeDetails"]["orders"].sum { |order| order["totalAmount"] }
    total_all_payments = data["financeDetails"]["payments"].sum { |order| order["amount"] }

    data["financeDetails"]["balance"] = total_all_orders - total_all_payments
  end
end
