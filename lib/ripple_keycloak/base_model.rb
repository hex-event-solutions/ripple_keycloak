# frozen_string_literal: true

module RippleKeycloak
  class BaseModel
    class << self
      delegate :get, :post, to: :client

      def object_type(object_type)
        @object_type = object_type
      end

      def search(value)
        client.get("#{@object_type}?search=#{value}")
      end

      def all(first: nil, max: nil)
        url = "#{@object_type}?"
        url += "first=#{first}&" if first
        url += "max=#{max}" if max

        client.get(url)
      end

      def find(id)
        client.get("#{@object_type}/#{id}")
      end

      def find_by(field:, value:)
        results = search(value).parsed_response
        if results.is_a? Array
          results.each do |instance|
            return instance if instance[field] == value
          end
        end
        raise NotFoundError, "Object type: #{@object_type}, field: #{field}, value: #{value}"
      end

      def delete(id)
        client.delete("#{@object_type}/#{id}")
      end

      private

      def client
        RippleKeycloak::Client.new
      end
    end

    delegate :object_type, to: :class
  end
end
