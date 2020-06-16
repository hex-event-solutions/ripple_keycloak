# frozen_string_literal: true

module RippleKeycloak
  class Role < BaseModel
    object_type 'roles'

    class << self
      def create(name:)
        payload = { name: name }
        response = client.post('roles', payload)
        role_id = response.headers['location'].split('/').last

        role_id
      end
    end
  end
end
