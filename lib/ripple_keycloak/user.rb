# frozen_string_literal: true

module RippleKeycloak
  class User
    class << self
      delegate :get, :post, to: :client

      def search(value)
        client.search('users', value)
      end

      def all
        client.get('users')
      end

      def find(id)
        client.get("users/#{id}")
      end

      def find_by(field:, value:)
        client.find_by('users', field, value)
      end

      def create(**properties)
        missing_properties = required_properties - properties.keys

        raise MissingPropertyError, missing_properties if missing_properties.any?

        payload = user_payload(properties)

        response = client.post('users', payload)
        user_id = response.headers['location'].split('/').last

        send_user_email(user_id, properties[:client_id], properties[:redirect_uri])

        user_id
      end

      private

      def client
        RippleKeycloak::Client.new
      end

      def required_properties
        %i[email first_name last_name phone client_id redirect_uri]
      end

      def user_payload(properties)
        {
          username: properties[:email],
          email: properties[:email],
          firstName: properties[:first_name],
          lastName: properties[:last_name],
          enabled: "true",
          requiredActions: ['UPDATE_PASSWORD'],
          attributes: {
            phone: properties[:phone]
          }
        }
      end

      def send_user_email(user_id, client_id, redirect_uri)
        client.put(
          "users/#{user_id}/execute-actions-email?" \
          'lifespan=86400&' \
          "client_id=#{client_id}&" \
          "redirect_uri=#{redirect_uri}",
          ['UPDATE_PASSWORD, VERIFY_EMAIL']
        )
      end
    end
  end
end
