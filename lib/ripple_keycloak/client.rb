# frozen_string_literal: true

require 'httparty'
require 'active_support/core_ext/module/delegation'

require 'ripple_keycloak/configuration'

module RippleKeycloak
  class Client
    include HTTParty
    debug_output $stdout

    class << self
      def configure
        @configuration = Configuration.new
        yield(configuration)
        auth
        'Success'
      end

      def post_formatted(resource, json: true, authed: true, **options)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end
        if json
          options = add_header(options, 'Content-Type', 'application/json')
          options[:body] = options[:body].to_json
        end

        return_or_raise post("#{base_uri}/#{resource}", options)
      end

      def get_formatted(resource, options = {}, authed: true)
        if authed
          options = add_auth_header(options)
          resource = "admin/realms/#{realm}/" + resource
        end

        return_or_raise get("#{base_uri}/#{resource}", options)
      end

      private

      attr_accessor :configuration,
                    :access_token,
                    :access_token_expiry

      delegate :base_url,
               :realm,
               :client_id,
               :client_secret,
               to: :configuration

      delegate :raise_error, to: :error_handler

      def return_or_raise(response)
        if response.code == 200
          response
        else
          raise_error response
        end
      end

      def auth
        response = post_formatted("realms/#{realm}/protocol/openid-connect/token", {
                                    body: {
                                      grant_type: 'client_credentials',
                                      client_id: client_id,
                                      client_secret: client_secret
                                    }
                                  }, json: false, authed: false)
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
        if access_token_expiry < now
          auth
        else
          access_token
        end
      end

      def add_auth_header(options)
        add_header(options, 'Authorization', "Bearer #{token}")
      end

      def add_header(options, header, value)
        options[:header] ||= {}
        options[:header] = options[:header].merge({ "#{header}": value })
        options
      end
    end

    def post(resource, body)
      self.class.post_formatted(resource, { body: body })
    end

    def get(resource)
      self.class.get_formatted(resource)
    end

    def search(type, value)
      get("#{type}?search=#{value}")
    end

    def find_by(type, field, value)
      results = search(type, value).parsed_response
      if results.is_a? Array
        results.each do |instance|
          return instance if instance[field] == value
        end
      end
      nil
    end
  end
end
