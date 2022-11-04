Rails.application.routes.draw do
  concern :searchable do
    get(
      'search',
      action: :search,
      on: :collection,
      as: :search
    )
  end

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
      resources :articles, concerns: %i[searchable]

      resources :users, concerns: %i[searchable] do
        member do
          get :make_admin, to: 'users#make_admin'
          get :make_member, to: 'users#make_member'
        end
      end

      get :system_test, to: 'system_test#index'

      root to: 'dashboard#index'
    end

    get '/:locale', to: 'homepage#index'

    root to: 'homepage#index'
  end
end
