# frozen_string_literal: true

module RippleKeycloak
  class Configuration
    attr_accessor :base_url,
                  :realm,
                  :client_id,
                  :client_secret
  end
end
