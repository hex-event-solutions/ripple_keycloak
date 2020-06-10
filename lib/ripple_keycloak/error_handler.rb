# frozen_string_literal: true

module RippleKeycloak
  class ErrorHandler
    class << self
      def error_map
        {
          'Realm does not exist' => RealmDoesNotExistError,
          'unauthorized_client' => UnauthorizedClientError,
          'HTTP 401 Unauthorized' => UnauthorizedError
        }
      end

      def raise_error(response)
        formatted_error = {
          code: response.code,
          body: response.parsed_response
        }

        raise RippleKeycloak::Error, formatted_error unless response.key? 'error'

        error_class = error_map[response['error']]

        raise error_class, formatted_error
      end
    end
  end
end
