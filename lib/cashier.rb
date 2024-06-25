# frozen_string_literal: true

require_relative 'product'
require_relative 'checkout'
require_relative 'pricing_rule'

module Cashier
  DEFAULT_PRODUCTS = {
    GR1: { name: 'Green tea', price: 3.11 },
    SR1: { name: 'Strawberries', price: 5.00 },
    CF1: { name: 'Coffee', price: 11.23 }
  }.freeze

  DEFAULT_PRICING_RULES = [
    # buy-one-get-one-free offer for green tea
    PricingRule.new do |items|
      teas = items.select { |item| item.code == 'GR1' }
      teas.each_slice(2) { |pair| pair[1].price = 0 if pair.size > 1 }
    end,
    # buy 3 strawberries or more, the price drop to £4.50 each
    PricingRule.new do |items|
      strawberries = items.select { |item| item.code == 'SR1' }
      strawberries.each { |item| item.price = 4.50 } if strawberries.size >= 3
    end,
    # buy 3 or more coffees, the price drop to 2/3 of the original price
    PricingRule.new do |items|
      coffees = items.select { |item| item.code == 'CF1' }
      coffees.each { |item| item.price = item.price * 2 / 3.0 } if coffees.size >= 3
    end
  ].freeze

  def self.print_products
    products = DEFAULT_PRODUCTS

    column_titles = {
      code: 'Product code',
      name: 'Name',
      price: 'Price'
    }

    # Calculate column widths
    code_width  = [*products.keys, column_titles[:code]].map(&:length).max
    name_width  = [*products.values.map { |v| v[:name] }, column_titles[:name]].map(&:length).max
    price_width = [*products.values.map { |v| format('£%.2f', v[:price]) }, column_titles[:price]].map(&:length).max

    # Print the header row
    header = "| #{column_titles[:code].ljust(code_width)} | #{column_titles[:name].ljust(name_width)} | #{column_titles[:price].ljust(price_width)} |"
    separator = "+-#{'-' * code_width}-+-#{'-' * name_width}-+-#{'-' * price_width}-+"

    puts separator
    puts header
    puts separator

    # Print each product row
    products.each do |code, details|
      price = format('£%.2f', details[:price])
      row = "| #{code.to_s.ljust(code_width)} | #{details[:name].ljust(name_width)} | #{price.ljust(price_width)} |"
      puts row
    end

    # Print the final separator
    puts separator
  end
end
