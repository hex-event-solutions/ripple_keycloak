# frozen_string_literal: true

module RippleKeycloak
  class Client
    include HTTParty

    class << self
      def configure
        configuration = Configuration.new
        yield(configuration)
      end

      private

      attr_accessor :configuration
    end

    private

    delegate :base_url,
             :client_id,
             :client_secret,
             :access_token,
             :refresh_token,
             :expires_in,
             :refresh_expires_in,
             to: :config

    def configuration
      self.class.configuration
    end

    def base_uri
      "#{base_url}/auth"
    end
  end
end
