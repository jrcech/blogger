Rails.application.routes.draw do
  concern :searchable do
    get(
      'search',
      action: :search,
      on: :collection,
      as: :search
    )
  end

  root to: 'homepage#index'

  devise_for(
    :users,
    only: :omniauth_callbacks,
    controllers: {
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
  )

  scope '(:locale)', locale: /en|cs/ do
    devise_for :users, skip: :omniauth_callbacks

    namespace :admin do
      root to: 'dashboard#index'

      resources :users, concerns: %i[searchable]

      resources :reviews, only: %i[index new create], concerns: %i[searchable]
      resources :comments, only: %i[index new create], concerns: %i[searchable]

      resources :articles, shallow: true, concerns: %i[searchable] do
        resources :reviews, concerns: %i[searchable]
        resources :comments, concerns: %i[searchable]
      end

      if Rails.env.development? || Rails.env.test?
        get :system_test, to: 'system_test#index'
      end
    end
  end

  get '/:locale', to: 'homepage#index'
end
