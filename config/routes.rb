require 'sidekiq/web'

Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedOut.new do
    root to: 'surveys#new', as: :admin_root
    resources :surveys, only: [:new, :create]
  end

  constraints Clearance::Constraints::SignedIn.new do
    mount Sidekiq::Web => '/sidekiq'
    root to: 'admin/surveys#index', as: :signed_in_root
    namespace :admin do
      resources :surveys, only: [:index, :destroy]
    end
  end
end
