# frozen_string_literal: true

module RippleKeycloak
  class ErrorHandler
    class << self
      def raise_error(response)
        raise RippleKeycloak::Error, response unless response.key? 'error'

        error_class = error_from_name(response['error'])

        raise error_class, response['error_description'] if response.key? 'error_description'

        raise error_class, response
      end

      def error_from_name(name)
        class_name = name.split(/[ _]/).map(&:capitalize).join + 'Error'
        if Object.const_defined?(class_name)
          Object.const_get(class_name)
        else
          RippleKeycloak::Error
        end
      end
    end
  end
end
