class UserServiceIntegrationsController < ApplicationController

    def new
        @user_service_integration = UserServiceIntegration.new_user_service_integration(:fitbit)
        service_auth_base_url = ServiceIntegration.find(@user_service_integration).service_authorization_url

        # define the URI parameters for the authorization page
        auth_client_id = "22873B"
        auth_secret = ENV["FITBIT_CLIENT_SECRET"]
        puts auth_secret
        auth_response_type = "code"
        auth_scope = "weight"
        auth_redirect_uri = "http%3A%2F%2simpleweighttracker.herokuapp.com%2Ffitbit_auth"
        auth_expires_in = "2592000" # attempt to set for 30 days
        params_string = "authorize?response_type=#{auth_response_type}&client_id=#{auth_client_id}&redirect_uri=#{auth_redirect_uri}&scope=#{auth_scope}&expires_in=#{auth_expires_in}"
        puts service_auth_base_url + params_string
    end

    def create
        # start the OAUTH procedure
        service_auth_base_url = @user_service_integration.service_integration.service_auth_url
        puts service_auth_base_url
    end 

    def fitbit_auth
        puts params.to_json
    end

end
