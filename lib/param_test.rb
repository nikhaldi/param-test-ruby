require 'active_support/test_case'
require 'active_support/testing/parametrized'

module ActiveSupport
  class TestCase
    extend ActiveSupport::Testing::Parametrized
  end
end
