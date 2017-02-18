# frozen_string_literal: true
Rails.application.routes.draw do
  constraints Clearance::Constraints::SignedIn.new do
    namespace :admin do
      resources :surveys
      resources :users

    end
    root to: "admin/surveys#index", as: :signed_in_root
  end


  constraints Clearance::Constraints::SignedOut.new do
    root to: "surveys#new"
    resources :surveys, only: [:new, :create]
  end
end
