# spec/checkout_spec.rb
require 'rspec'
require 'bigdecimal'
require 'bigdecimal/util'
require_relative '../lib/checkout'
require_relative '../lib/product'
require_relative '../lib/rules/buy_one_get_one_free_rule'
require_relative '../lib/rules/bulk_discount_rule'
require_relative '../lib/rules/percentage_discount_rule'

RSpec.describe Checkout do
  let(:green_tea) { Product.new('GR1', 'Green tea', "3.11".to_d) }
  let(:strawberries) { Product.new('SR1', 'Strawberries', "5.00".to_d) }
  let(:coffee) { Product.new('CF1', 'Coffee', "11.23".to_d) }

  let(:pricing_rules) do
    [
      BuyOneGetOneFreeRule.new('GR1'),
      BulkDiscountRule.new('SR1', 3, "4.50".to_d),
      PercentageDiscountRule.new('CF1', 3, BigDecimal("2")/BigDecimal("3"))
    ]
  end

  subject(:checkout) { Checkout.new(pricing_rules) }

  def scan_items(items)
    items.each { |item| checkout.scan(item) }
  end

  def money(value)
    BigDecimal(value.to_s).round(2)
  end

  context 'integration tests from requirements' do
    it 'Basket: GR1, SR1, GR1, GR1, CF1 -> Total: £22.45' do
      scan_items([green_tea, strawberries, green_tea, green_tea, coffee])
      expect(checkout.total).to eq(money(22.45))
    end

    it 'Basket: GR1, GR1 -> Total: £3.11' do
      scan_items([green_tea, green_tea])
      expect(checkout.total).to eq(money(3.11))
    end

    it 'Basket: SR1, SR1, GR1, SR1 -> Total: £16.61' do
      scan_items([strawberries, strawberries, green_tea, strawberries])
      expect(checkout.total).to eq(money(16.61))
    end

    it 'Basket: GR1, CF1, SR1, CF1, CF1 -> Total: £30.57' do
      scan_items([green_tea, coffee, strawberries, coffee, coffee])
      expect(checkout.total).to eq(money(30.57))
    end
  end
end
