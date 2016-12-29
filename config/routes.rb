Rails.application.routes.draw do
    root 'static_pages#index'    
    devise_for :users, paths: 'users'
    resource :user do
        resources :user_profiles, shallow: true
        resources :weight_entries, shallow: true
    end
end
