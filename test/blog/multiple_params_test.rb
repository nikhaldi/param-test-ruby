require 'whitespace'
require 'param_test'
require 'test/unit'

class MultipleParamsTest < ActiveSupport::TestCase
  param_test "%s includes whitespace is %s", [
    ["hello world", true],
    ["foo bar", true],
    ["foo", false],
  ] do |input, expected|
    assert_equal expected, includes_whitespace?(input)
  end
end
