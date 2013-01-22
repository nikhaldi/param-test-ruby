require 'helper'

class ParamTestMetaTest < ActiveSupport::TestCase

  def assert_test_method_count(clazz, expected_count)
    instance_methods = clazz.instance_methods - clazz.superclass.instance_methods
    assert_equal expected_count, instance_methods.grep(/^test/).size
  end

  def assert_has_test_method(clazz, expected_method_name)
    assert_include clazz.instance_methods, expected_method_name
  end

  test "empty parameters adds no tests" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "adds no tests", [] do || end
    end
    assert_test_method_count test_case, 0
  end

  test "single parameter list adds one test" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "adds one test %s", [42] do |param| end
    end
    assert_test_method_count test_case, 1
    assert_has_test_method test_case, :test_adds_one_test_42
  end

  test "multiple parameters generate correct method name" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "adds one test %s two params %s", [[41, 42]] do |first, second| end
    end
    assert_test_method_count test_case, 1
    assert_has_test_method test_case, :test_adds_one_test_41_two_params_42
  end

  test "two parameter lists generate two methods" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "with two params %s %s",
        [[41, 42], [43, 44]] do |first, second| end
    end
    assert_test_method_count test_case, 2
    assert_has_test_method test_case, :test_with_two_params_41_42
    assert_has_test_method test_case, :test_with_two_params_43_44
  end

  param_test "mismatching parameter list %s fails for %s", [
    [[[43]], "%s %s"],
    [[[41, 42, 43]], "%s %s"],
  ] do |params, description|
    assert_raise ArgumentError do
      Class.new ActiveSupport::TestCase do
        param_test description,
          params do |first, second| end
      end
    end
  end

  test "wrong block arity fails" do
    assert_raise ArgumentError do
      Class.new ActiveSupport::TestCase do
        param_test "%s %s",
          [[41, 42]] do |first| end
      end
    end
  end

  test "more wrong block arity fails" do
    assert_raise ArgumentError do
      Class.new ActiveSupport::TestCase do
        param_test "%s %s",
          [[41, 42]] do |first, second, third| end
      end
    end
  end

  test "substitutes nil string for nil" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "params %s %s",
        [[nil, nil]] do |first, second| end
    end
    assert_test_method_count test_case, 1
    assert_has_test_method test_case, :test_params_nil_nil
  end

  test "generates unique test names" do
    test_case = Class.new ActiveSupport::TestCase do
      param_test "param %s",
        [nil, "nil", "", " ", "\n  \t"] do |param| end
    end
    assert_test_method_count test_case, 5
    assert_has_test_method test_case, :test_param_nil
    assert_has_test_method test_case, :test_param_nil_1
    assert_has_test_method test_case, :test_param_
    assert_has_test_method test_case, :test_param_1
    assert_has_test_method test_case, :test_param_2
  end

end
