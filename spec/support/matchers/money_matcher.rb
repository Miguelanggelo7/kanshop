require 'bigdecimal'

RSpec::Matchers.define :money_eq do |expected|
  match do |actual|
    BigDecimal(actual.to_s).round(2) == BigDecimal(expected.to_s).round(2)
  end

  failure_message do |actual|
    "expected #{format_money(actual)} to equal #{format_money(expected)} (rounded to 2 decimals)"
  end

  def format_money(value)
    BigDecimal(value.to_s).round(2).to_s("F")
  end
end