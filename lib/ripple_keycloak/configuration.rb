# frozen_string_literal: true

module RippleKeycloak
  class Configuration
    attr_accessor :base_url,
                  :client_id,
                  :client_secret,
                  :access_token,
                  :refresh_token,
                  :expires_in,
                  :refresh_expires_in
  end
end
