class ServiceIntegration < ApplicationRecord

    include Encryption

    validates :service_name, presence: true
    validates :service_authorization_url, presence: true
    validates :service_base_api_url, presence: true

    attr_encrypted :service_client_id, :key => :encryption_key
end
