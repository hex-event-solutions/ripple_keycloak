# frozen_string_literal: true

require 'ripple_keycloak/version'
require 'ripple_keycloak/client'

module RippleKeycloak
  class Error < StandardError; end
  class UnauthorizedClientError < StandardError; end
  class RealmDoesNotExistError < StandardError; end
end
