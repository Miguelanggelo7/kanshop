require 'rspec'
require 'bigdecimal/util'
require_relative '../../lib/product'
require_relative '../../lib/rules/percentage_discount_rule'

RSpec.describe PercentageDiscountRule do
  let(:coffee) { Product.new('CF1', 'Coffee', 11.23) }
  subject(:rule) { described_class.new('CF1', 3, BigDecimal("2")/BigDecimal("3")) }

  it 'applies discount when buying 3 or more' do
    items = [coffee, coffee, coffee]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(22.46) # 3 * (11.23 * 2/3)
  end

  it 'does not apply discount when buying less than 3' do
    items = [coffee, coffee]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(22.46) # 2 * 11.23
  end
end
