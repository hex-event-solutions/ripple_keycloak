# frozen_string_literal: true

module RippleKeycloak
  class User < BaseModel
    object_type 'users'

    class << self
      def create(payload)
        response = client.post('users', payload)
        user_id = response.headers['location'].split('/').last

        user_id
      end

      def add_to_group(user_id, group_id)
        client.put("users/#{user_id}/groups/#{group_id}", {
          groupId: group_id,
          userId: user_id
        })
      end

      def remove_from_group(user_id, group_id)
        client.delete("users/#{user_id}/groups/#{group_id}")
      end

      def add_role(user_id, role_name)
        role = RippleKeycloak::Role.find_by(field: 'name', value: role_name)
        client.post("users/#{user_id}/role-mappings/realm", [role])
      end

      def remove_role(user_id, role_name)
        role = RippleKeycloak::Role.find_by(field: 'name', value: role_name)
        client.delete("users/#{user_id}/role-mappings/realm", [role])
      end

      def send_email(user_id, actions, lifespan: 86400, client_id: false, redirect_uri: false)
        url = "users/#{user_id}/execute-actions-email?"
        url += "?lifespan=#{lifespan}"
        url += "&client_id=#{client_id}" if client_id
        url += "&redirect_uri=#{redirect_uri}" if redirect_uri

        client.put(url, actions)
      end
    end
  end
end
