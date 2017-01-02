class CreateServiceIntegrations < ActiveRecord::Migration[5.0]
  def change
    create_table :service_integrations do |t|
      t.string :service_name
      t.string :service_authorization_url
      t.string :service_base_api_url
      t.timestamps
    end

    # create the first ServiceIntegration
    ServiceIntegration.create!(service_name: 'FitBit', 
                              service_authorization_url: 'https://www.fitbit.com/oauth2/', 
                              service_base_api_url: 'https://api.fitbit.com')
                              
  end
end
