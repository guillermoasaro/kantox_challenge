# frozen_string_literal: true

require_relative 'product'
require_relative 'checkout'
require_relative 'pricing_rule'

module Cashier
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
end
