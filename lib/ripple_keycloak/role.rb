# frozen_string_literal: true

module RippleKeycloak
  class Role
    class << self
      delegate :get, :post, to: :client

      def find_by(field:, value:)
        client.find_by('roles', field, value)
      end

      private

      def client
        RippleKeycloak::Client.new
      end
    end
  end
end
