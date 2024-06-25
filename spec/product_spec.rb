# frozen_string_literal: true

require 'rspec'
require_relative '../lib/product'

RSpec.describe Product do
  describe 'Initialization' do
    let(:product) { Product.new('GR1', 'Green tea', 3.11) }

    it 'has a code' do
      expect(product.code).to eq('GR1')
    end

    it 'has a name' do
      expect(product.name).to eq('Green tea')
    end

    it 'has a price' do
      expect(product.price).to eq(3.11)
    end
  end
end
