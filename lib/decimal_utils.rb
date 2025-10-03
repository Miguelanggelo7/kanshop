require 'bigdecimal'

module DecimalUtils
  module_function

  def coerce(value)
    value.is_a?(BigDecimal) ? value : BigDecimal(value.to_s)
  end
end
