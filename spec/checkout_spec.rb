# frozen_string_literal: true

require 'rspec'
require_relative '../lib/cashier'

RSpec.describe Checkout do
  let(:green_tea) { Product.new('GR1', 'Green tea', 3.11) }
  let(:strawberries) { Product.new('SR1', 'Strawberries', 5.00) }
  let(:coffee) { Product.new('CF1', 'Coffee', 11.23) }
  let(:pricing_rules) { Cashier::DEFAULT_PRICING_RULES }

  subject(:checkout) { described_class.new(pricing_rules) }

  describe 'Basket: GR1, SR1, GR1, GR1, CF1' do
    it 'returns a total of £22.45' do
      checkout.scan(green_tea)
      checkout.scan(strawberries)
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      checkout.scan(coffee)
      expect(checkout.total).to eq(22.45)
    end
  end

  describe 'Basket: GR1, GR1' do
    it 'returns a total of £3.11' do
      checkout.scan(green_tea)
      checkout.scan(green_tea)
      expect(checkout.total).to eq(3.11)
    end
  end

  describe 'Basket: SR1, SR1, GR1, SR1' do
    it 'returns a total of £16.61' do
      checkout.scan(strawberries)
      checkout.scan(strawberries)
      checkout.scan(green_tea)
      checkout.scan(strawberries)
      expect(checkout.total).to eq(16.61)
    end
  end

  describe 'Basket: GR1, CF1, SR1, CF1, CF1' do
    it 'returns a total of £30.57' do
      checkout.scan(green_tea)
      checkout.scan(coffee)
      checkout.scan(strawberries)
      checkout.scan(coffee)
      checkout.scan(coffee)
      expect(checkout.total).to eq(30.57)
    end
  end
end
