# frozen_string_literal: true

require 'ripple_keycloak/version'
require 'ripple_keycloak/client'
require 'ripple_keycloak/base_model'
require 'ripple_keycloak/group'
require 'ripple_keycloak/role'
require 'ripple_keycloak/user'

module RippleKeycloak
  class Error < StandardError; end
  class UnauthorizedClientError < Error; end
  class UnauthorizedError < Error; end
  class RealmDoesNotExistError < Error; end
  class GroupNotFoundError < Error; end
  class RoleNotFoundError < Error; end
  class UserNotFoundError < Error; end
  class MissingPropertyError < Error; end
  class NotFoundError < Error; end

  class ConflictError < Error; end
end
