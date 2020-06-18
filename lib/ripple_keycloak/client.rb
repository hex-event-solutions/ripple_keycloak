# frozen_string_literal: true

require 'httparty'
require 'active_support/core_ext/module/delegation'

require 'ripple_keycloak/error_handler'
require 'ripple_keycloak/configuration'

module RippleKeycloak
  class Client
    include HTTParty
    # debug_output $stdout

    class << self
      def configure
        @configuration = Configuration.new
        yield(configuration)
        auth
        'Authenticated successfully'
      end

      def post_formatted(resource, json: true, authed: true, **options)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end
        options = format_as_json(options) if json

        return_or_raise post("#{base_uri}/#{resource}", options)
      end

      def put_formatted(resource, json: true, authed: true, **options)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end
        options = format_as_json(options) if json

        return_or_raise put("#{base_uri}/#{resource}", options)
      end

      def get_formatted(resource, authed: true, **options)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end

        return_or_raise get("#{base_uri}/#{resource}", options)
      end

      def delete_formatted(resource, json: true, authed: true, **options)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end
        options = format_as_json(options) if json

        return_or_raise delete("#{base_uri}/#{resource}", options)
      end

      private

      attr_accessor :configuration, :access_token, :access_token_expiry

      delegate :base_url, :realm, :client_id, :client_secret, to: :configuration

      delegate :raise_error, to: :error_handler

      def format_as_json(options)
        options = add_header(options, 'Content-Type', 'application/json')
        options[:body] = options[:body].to_json
        options
      end

      def return_or_raise(response)
        return response if [200, 201, 204].include? response.code

        raise_error response
      end

      def auth
        response = post_formatted(
          "realms/#{realm}/protocol/openid-connect/token",
          body: { grant_type: 'client_credentials', client_id: client_id, client_secret: client_secret },
          json: false, authed: false
        )
        update_token_fields response
        access_token
      end

      def update_token_fields(response)
        @access_token = response['access_token']
        @access_token_expiry = Time.now + response['expires_in']
      end

      def base_uri
        "#{base_url}/auth"
      end

      def error_handler
        ErrorHandler
      end

      def token
        now = Time.now
        return auth if access_token_expiry < now

        access_token
      end

      def add_auth_header(options)
        add_header(options, 'Authorization', "Bearer #{token}")
      end

      def add_header(options, header, value)
        options[:headers] ||= {}
        options[:headers] = options[:headers].merge({ "#{header}": value })
        options
      end
    end

    def post(resource, body)
      self.class.post_formatted(resource, body: body)
    end

    def put(resource, body)
      self.class.put_formatted(resource, body: body)
    end

    def get(resource)
      self.class.get_formatted(resource)
    end

    def delete(resource, body = {})
      self.class.delete_formatted(resource, body: body)
    end
  end
end
