require 'helper'

class ParamTestTest < ActiveSupport::TestCase

  param_test "single parameter: %s", [1, 2, 3] do |param|
    assert param.is_a? Numeric
  end

  param_test "multiple parameters: %s %s",
  [[1, 1], [2, 2], [3, 3]] do |first_param, second_param|
    assert_equal first_param, second_param
  end

end
