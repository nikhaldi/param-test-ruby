require 'whitespace'
require 'test/unit'

class BadLoopingTest < Test::Unit::TestCase
  def test_includes_whitespace
    inputs = ["hello world", "foo bar", "foo", "bar\n"]
    inputs.each do |input|
      assert includes_whitespace? input
    end
  end
end
