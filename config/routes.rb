Rails.application.routes.draw do
  concern :searchable do
    get 'search', action: :search, on: :collection, as: :search
  end

  get 'up', to: 'rails/health#show', as: :rails_health_check

  root 'homepage#index'

  scope '(:locale)', locale: /en|cs/ do
    scope module: :authentication do
      resource :session, only: %i[new create destroy]
      resource :registration, only: %i[new create]
      resource :password_reset, only: %i[new edit create update]
      resource :password, only: %i[edit update]
    end

    namespace :admin do
      root 'dashboard#index'

      resources :users, concerns: %i[searchable]

      resources :reviews, only: %i[index new create], concerns: %i[searchable]
      resources :comments, only: %i[index new create], concerns: %i[searchable]
      resources :technologies, only: %i[index new create], concerns: %i[searchable]

      resources :articles, shallow: true, concerns: %i[searchable] do
        resources :reviews, concerns: %i[searchable]
        resources :comments, concerns: %i[searchable]
        resources :technologies, concerns: %i[searchable]
      end

      resource :integration, only: %i[show] if Rails.env.local?
    end
  end
end
