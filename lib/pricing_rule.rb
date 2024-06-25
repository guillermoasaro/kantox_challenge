# frozen_string_literal: true

class PricingRule
  def initialize(&block)
    @block = block
  end

  def apply(items)
    @block.call(items)
  end
end
