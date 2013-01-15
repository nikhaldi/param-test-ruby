require 'helper'

class ParamTestTest < ActiveSupport::TestCase

  param_test "single parameter: %s", [1, 2, 3] do |param|
    assert param.is_a? Numeric
  end

  param_test "multiple parameters: %s %s",
  [[1, 1], [2, 2], [3, 3]] do |first_param, second_param|
    assert_equal first_param, second_param
  end

  # Example from the rdoc string
  param_test "string %s is ASCII only",
  ["foo", "bar", "baz"] do |string|
    assert string.ascii_only?
  end

  # 2nd example from the rdoc string
  param_test "%s is uppercase %s",
  [["FOO", "foo"], ["BAR", "bar"]] do |expected, param|
    assert_equal expected, param.upcase
  end
end
