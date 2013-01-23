require 'whitespace'
require 'param_test'
require 'test/unit'

class SingleParamTest < ActiveSupport::TestCase
  param_test "%s includes whitespace",
  ["hello world", "foo bar", "foo", "bar\n"] do |input|
    assert includes_whitespace? input
  end
end
