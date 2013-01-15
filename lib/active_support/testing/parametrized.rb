module ActiveSupport
  module Testing
    module Parametrized

      # TODO doc
      def param_test(description_template, parameters, &block)
        parameters.each do |param_set|
          # Replacing nil values with 'nil' string because nil values will
          # get converted to an empty string within a test name.
          if param_set.kind_of? Array
            sanitized_param_set = param_set.map do |param|
              param.nil? ? 'nil' : param
            end
          else
            sanitized_param_set = param_set.nil? ? 'nil' : param_set
          end

          begin
            description = description_template % sanitized_param_set
          rescue ArgumentError
            raise ArgumentError, "Parameter set #{param_set} doesn't match number " +
              "of arguments expected by description template '#{description_template}'"
          end

          # Make sure the description generates a unique test method name.
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
    end
  end
end
