module ActiveSupport
  module Testing
    module Parametrized

      # TODO doc
      def param_test(description_template, parameters, &block)
        parameters.each do |param_set|
          description = description_template % param_set
          test description do
            instance_exec param_set, &block
          end
        end
      end

    end
  end
end
