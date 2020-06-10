# frozen_string_literal: true

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

      def create(name:, parent: false, role: false)
        payload = { name: name }
        path = create_path(parent)
        role_result = find_role(role)
        response = client.post(path, payload)
        group_id = response.headers['location'].split('/').last
        add_role(group_id, role_result)

        group_id
      end

      private

      def client
        RippleKeycloak::Client.new
      end

      def create_path(parent)
        if parent
          parent_group = find_by(field: 'name', value: parent)
          raise GroupNotFoundError, parent unless parent_group

          path = "groups/#{parent_group['id']}/children"
        else
          path = 'groups'
        end
        path
      end

      def add_role(group_id, role)
        client.post("groups/#{group_id}/role-mappings/realm", [role])
      end

      def find_role(role)
        role_result = RippleKeycloak::Role.find_by(field: 'name', value: role)
        raise RoleNotFoundError, role unless role_result

        role_result
      end
    end
  end
end
