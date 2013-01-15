param_test
==========

**Parametrized unit tests for Ruby/ActiveSupport**

This gem extends `ActiveSupport::TestCase` with a simple `param_test` class method that generates multiple tests with different parameters from a single code block.


## Usage

In unit tests, you'll often want to run a set of the same assertions on multiple inputs. One way to do this is by looping over the inputs, for example:

    class StringTest < ActiveSupport::TestCase

      test "strings are ASCII only" do
        ["foo", "bar", "baz"].each do |string|
          # Bad programmer! Don't do this
          assert string.ascii_only?
        end
      end

    end

**Don't do this!** This is almost always a bad idea. If this test fails you won't know at which of the 3 input parameters it failed. A failure will also prevent subsequent inputs from getting tested, masking other failures that you won't discover until later.

`param_test` addresses these problems. The above test should be rewritten like this:

    require 'param_test'

    class StringTest < ActiveSupport::TestCase

      param_test "string %s is ASCII only",
	  ["foo", "bar", "baz"] do |string|
	    assert string.ascii_only?
	  end

    end

This will generate three separate tests, one for each of the three parameters (`"foo"`, `"bar"` and `"baz"`) passed in the second argument. Each test is independent and can fail independently.

The tests will be named after the description template passed as the first argument. Standard Ruby string formatting is used to substitute the parameters into the description. Generally you'll want to just use string substitution with `%s`.

You can have multiple parameters per test:

    param_test "%s is uppercase %s",
    [["FOO", "foo"], ["BAR", "bar"]] do |expected, param|
      assert_equal expected, param.upcase
    end

Each parameter set must have the same number of parameters. The description template must have a corresponding number of substitutions.

### About Test Naming

Ruby's underlying unit test framework requires tests to be defined as methods beginning with `test`, so the description is actually converted to a valid method name. In the last example, the methods generated are `:test_FOO_is_uppercase_foo` and `:test_BAR_is_uppercase_bar`.

If string substitution would create the same method names for two different sets of parameters (this can happen because for example any all-whitespace string converts to the same single underscore), a counting variable will be added to the method name to keep them unique.

For better readability, any `nil` parameters will be string substituted as a `"nil"` string (the default string substitution for `nil` values is the empty string).


## Installation

    gem install param_test


## License

Distributed under an [MIT license](https://github.com/nikhaldi/param-test-ruby/blob/master/LICENSE.md).
