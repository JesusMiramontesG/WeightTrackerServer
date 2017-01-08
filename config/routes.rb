Rails.application.routes.draw do
    root 'static_pages#index'    
    devise_for :users, paths: 'users'

    get 'fitbit_auth/:access_token/:expires_in/:scope/:state/:token_type/:user_id', to: 'user_service_integrations#fitbit_auth'

    resource :user do
        resources :user_profiles, shallow: true
        resources :weight_entries, shallow: true
        resources :user_service_integrations, shallow: true
    end

    get 'profile', to: 'user_profiles#edit', as: 'pretty_user_profile'
    get 'weight-entries', to: 'weight_entries#index', as: 'pretty_weight_entries'
end
