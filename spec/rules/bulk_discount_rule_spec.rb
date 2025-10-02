require 'rspec'
require 'bigdecimal/util'
require_relative '../../lib/product'
require_relative '../../lib/rules/bulk_discount_rule'

RSpec.describe BulkDiscountRule do
  let(:strawberry) { Product.new('SR1', 'Strawberries', 5.00) }
  subject(:rule)   { described_class.new('SR1', 3, 4.50) }

  it 'applies discount when buying 3 or more' do
    items = [strawberry, strawberry, strawberry]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(13.50)
  end

  it 'does not apply discount when buying less than 3' do
    items = [strawberry, strawberry]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(10.00)
  end
end
