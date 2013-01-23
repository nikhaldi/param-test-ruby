require 'whitespace'
require 'active_support/test_case'
require 'test/unit'

class BadDeclarativeTest < ActiveSupport::TestCase
  ["  ", "\n"].each do |input|
    test "#{input} includes whitespace" do
      assert includes_whitespace? input
    end
  end
end
