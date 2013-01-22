module ActiveSupport
  module Testing
    module Parametrized

      # Generates parametrized tests, one for each set of parameters given.
      # The description must be a format specification with the same number
      # of substitutions as each parameter set has arguments (generally,
      # just use one '%s' substitution per parameter). The body of the test
      # is the given block executed with each parameter set.
      #
      # = Examples
      #
      # This code within an ActiveSupport::Testcase
      #
      #   param_test "string %s is ASCII only",
      #   ["foo", "bar", "baz"] do |string|
      #     assert string.ascii_only?
      #   end
      #
      # Generates 3 test methods, one for each parameter given, with names
      # based on the description.
      #
      # Another example with multiple parameters, generating 2 test methods:
      #
      #   param_test "%s is uppercase %s",
      #   [["FOO", "foo"], ["BAR", "bar"]] do |expected, param|
      #     assert_equal expected, param.upcase
      #   end
      #
      def param_test(description_template, parameters, &block)
        param_count = format_sequence_count(description_template)

        parameters.each do |param_set|
          # Replacing nil values with 'nil' string because nil values will
          # get converted to an empty string within a test name.
          if param_set.kind_of? Array
            sanitized_param_set = param_set.map do |param|
              param.nil? ? 'nil' : param
            end
          else
            sanitized_param_set = param_set.nil? ? ['nil'] : [param_set]
          end

          if param_count != sanitized_param_set.size
            raise ArgumentError, "Parameter set #{sanitized_param_set} doesn't match number " +
              "of arguments expected by description template '#{description_template}'"
          end

          # Make sure the description generates a unique test method name.
          description = description_template % sanitized_param_set
          unique_description = description
          if instance_methods.include? generate_test_name(unique_description)
            count = 1
            description += " %s"
            unique_description = description % count
          end
          while instance_methods.include? generate_test_name(unique_description)
            count += 1
            unique_description = description % count
          end

          test unique_description do
            instance_exec param_set, &block
          end
        end
      end

      private

      def generate_test_name(description)
        # Declarative 'test' uses the same substitution of whitespace.
        sanitized_description = description.gsub(/\s+/,'_')
        "test_#{sanitized_description}".to_sym
      end

      def format_sequence_count(format_string)
        sequences = format_string.scan(/%+/).select do |match|
          match.size.odd?
        end
        sequences.size
      end
    end
  end
end
