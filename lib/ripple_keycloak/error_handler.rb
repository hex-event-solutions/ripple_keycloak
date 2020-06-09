# frozen_string_literal: true

module RippleKeycloak
  class ErrorHandler
    class << self
      def raise_error(response)
        if response.has_key? 'error'
          error_class = error_from_name(response['error'])
          if response.has_key? 'error_description'
            raise error_class, response['error_description']
          else
            raise error_class, response
          end
        else
          raise RippleKeycloak::Error, response
        end
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
