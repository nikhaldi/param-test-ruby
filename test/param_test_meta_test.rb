require 'helper'

class ParamTestMetaTest < ActiveSupport::TestCase

  def assert_test_method_count(clazz, expected_count)
    instance_methods = clazz.instance_methods - clazz.superclass.instance_methods
    assert_equal expected_count, instance_methods.grep(/^test/).size
  end

  test "empty parameters list adds no tests" do
    class SampleTest < ActiveSupport::TestCase
      param_test "adds no tests", [] do |param| end
    end
    assert_test_method_count SampleTest, 0
  end

  test "single parameter adds one test" do
    class SampleTest < ActiveSupport::TestCase
      param_test "adds one tests %s", [42] do |param| end
    end
    assert_test_method_count SampleTest, 1
  end

end
