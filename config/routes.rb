# frozen_string_literal: true

Rails.application.routes.draw do
  require "sidekiq/web"
  mount Sidekiq::Web, at: "/sidekiq"

  root to: "dashboards#home"
  get "/auth/:provider/callback", to: "session#create"
  get "/login", to: "session#login"

  resources :users, only: [:new, :create]

  resources :dashboards, only: [:index]

  namespace :api do
    namespace :v1 do
      namespace :github do
        resources :users, only: [:show] do
          resources :commits, only: [:index]
        end
      end
    end
  end
end
