require 'devise/oauth2_providable/strategies/oauth2_grant_type_strategy'
require 'devise/oauth2_providable/custom_authenticatable_error'

module Devise
  module Strategies
    class Oauth2AuthorizationCodeGrantTypeStrategy < Oauth2GrantTypeStrategy
      def grant_type
        'authorization_code'
      end

      def authenticate_grant_type(client)
        if code = client.authorization_codes.find_by_token(params[:code])
          success! code.user
        else
          oauth_error! resource.unauthenticated_message
        end
      end
    end
  end
end

Warden::Strategies.add(:oauth2_authorization_code_grantable, Devise::Strategies::Oauth2AuthorizationCodeGrantTypeStrategy)
