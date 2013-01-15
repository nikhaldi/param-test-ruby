module ActiveSupport
  module Testing
    module Parametrized

      # TODO doc
      def param_test(description_template, parameters, &block)
        parameters.each do |param_set|
          begin
            description = description_template % param_set
          rescue ArgumentError
            raise ArgumentError, "Parameter set #{param_set} doesn't match number " +
              "of arguments expected by description template '#{description_template}'"
          end
          test description do
            instance_exec param_set, &block
          end
        end
      end

    end
  end
end
