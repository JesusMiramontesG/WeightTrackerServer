class UserServiceIntegration < ApplicationRecord

    include Encryption

    belongs_to :user
    has_one :service_integration

    def UserServiceIntegration.new_user_service_integration(type)
        user_service_integration = UserServiceIntegration.new
        if type == :fitbit
            # get the fitbit integration for now
            service_integration = ServiceIntegration.find(1)
            user_service_integration.service_integration_id = service_integration.id
        end
    end
end
