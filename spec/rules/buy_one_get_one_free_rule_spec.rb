require 'rspec'
require 'bigdecimal/util'
require_relative '../../lib/product'
require_relative '../../lib/rules/buy_one_get_one_free_rule'

RSpec.describe BuyOneGetOneFreeRule do
  let(:green_tea) { Product.new('GR1', 'Green tea', 3.11) }
  let(:other)     { Product.new('XX1', 'Other', 1.00) }
  subject(:rule)  { described_class.new('GR1') }

  it 'charges only one when two are added' do
    items = [green_tea, green_tea]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(3.11)
  end

  it 'charges two when three are added' do
    items = [green_tea, green_tea, green_tea]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(6.22)
  end

  it 'does not affect other products' do
    items = [other, green_tea, green_tea]
    result = rule.apply(items)
    total  = result.map(&:price).sum
    expect(total).to money_eq(4.11)
  end
end
