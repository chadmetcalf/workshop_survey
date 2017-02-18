# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :admin do
    resources :surveys
    resources :users

    root to: "surveys#new"
  end

  root to: "surveys#new"
  resources :surveys, only: [:new, :create]
end
