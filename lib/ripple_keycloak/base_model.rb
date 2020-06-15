# frozen_string_literal: true

module RippleKeycloak
  class BaseModel
    class << self
      delegate :get, :post, to: :client

      def object_type(object_type)
        @object_type = object_type
      end

      def search(value)
        client.search(@object_type, value)
      end

      def all(first: nil, max: nil)
        url = "#{@object_type}?"
        url += "first=#{first}" if first
        url += "max=#{max}" if max

        client.get(url)
      end

      def find(id)
        client.get("#{@object_type}/#{id}")
      end

      def find_by(field:, value:)
        client.find_by(@object_type, field, value)
      end

      def delete(id)
        client.delete("#{@object_type}/#{id}")
      end

      private

      def client
        RippleKeycloak::Client.new
      end
    end

    delegate :base_model, to: :class
  end
end
