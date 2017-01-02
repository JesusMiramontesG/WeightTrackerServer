class CreateUserServiceIntegrations < ActiveRecord::Migration[5.0]
  def change
    create_table :user_service_integrations do |t|
      t.references :user, foreign_key: true
      t.references :service_integration, foreign_key: true
      t.string :encrypted_authorization_token
      t.string :encrypted_authorization_token_iv
      t.string :encrypted_access_token
      t.string :encrypted_access_token_iv
      t.string :encrypted_refresh_token
      t.string :encrypted_refresh_token_iv

      t.timestamps
    end
  end
end
