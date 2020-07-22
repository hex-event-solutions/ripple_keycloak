# frozen_string_literal: true

module RippleKeycloak
  class Group < BaseModel
    object_type 'groups'

    class << self
      def create(name:, parent: false)
        payload = { name: name }
        path = create_path(parent)
        response = client.post(path, payload)
        group_id = response.headers['location'].split('/').last

        group_id
      end

      def add_role(group_id, role_name)
        role = RippleKeycloak::Role.find_by(field: 'name', value: role_name)
        client.post("groups/#{group_id}/role-mappings/realm", [role])
      end

      def remove_role(group_id, role_name)
        role = RippleKeycloak::Role.find_by(field: 'name', value: role_name)
        client.delete("groups/#{group_id}/role-mappings/realm", [role])
      end

      def members(group_id)
        client.get("groups/#{group_id}/members")
      end

      private

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
    end
  end
end
