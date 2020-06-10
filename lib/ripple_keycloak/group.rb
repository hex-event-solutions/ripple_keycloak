# frozen_string_literal: true

require 'ripple_keycloak/client'

module RippleKeycloak
  class Group
    class << self
      delegate :get, :post, to: :client

      def search(value)
        client.search('groups', value)
      end

      def all
        client.get('groups')
      end

      def find(id)
        client.get("groups/#{id}")
      end

      def find_by(field:, value:)
        client.find_by('groups', field, value)
      end

      def create(name:, parent:, role:)
        body = { name: name }
        path = create_path(parent)
        response = client.post(path, { body: body })
        group_id = response.headers['location'].split('/').last
        add_role(group_id, role) if role

        group_id
      end

      private

      def client
        RippleKeycloak::Client.new
      end

      def create_path(parent)
        if parent
          parent_id = find_by(field: 'name', value: parent)
          path = "groups/#{parent_id}/children"
        else
          path = 'groups'
        end
        path
      end

      def add_role(group_id, role)
        client.post("groups/#{group_id}/role-mappings/realm", { body: [role] })
      end
    end
  end
end
