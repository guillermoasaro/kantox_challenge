# frozen_string_literal: true

class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items << item.dup
  end

  def total
    @pricing_rules.each { |rule| rule.apply(@items) }
    @items.sum(&:price).round(2)
  end
end
