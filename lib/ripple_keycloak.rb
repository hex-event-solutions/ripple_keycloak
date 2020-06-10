# frozen_string_literal: true

require 'ripple_keycloak/version'
require 'ripple_keycloak/client'
require 'ripple_keycloak/group'
require 'ripple_keycloak/role'

module RippleKeycloak
  class Error < StandardError; end
  class UnauthorizedClientError < StandardError; end
  class UnauthorizedError < StandardError; end
  class RealmDoesNotExistError < StandardError; end
  class GroupNotFoundError < StandardError; end
  class RoleNotFoundError < StandardError; end
end
