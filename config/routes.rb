Rails.application.routes.draw do
  resources :componentes
  root 'home#index'

  mount ActionCable.server => '/cable'

  devise_for :usuarios, controllers: {
    confirmations: 'confirmations'
  }
  as :usuario do
    patch '/confirm' => 'confirmations#confirm'
  end

  devise_for :admin, controllers: {
    sessions: 'admin/devise/sessions'
  }

  get '/usuarios' => redirect('/usuarios/sign_in')
  get '/admin' => redirect('/admin/sign_in')

  resources :grupos do
    resources :usuarios
    resources :ambientes do
      resources :componentes_ambiente, shallow: true do
        resources :layout_controles, shallow: true
      end
    end
  end

  namespace :api do
    namespace :request do
      post :google_api_request
    end
    namespace :componentes do
      post :publish
      post :recebe_estado
    end
  end

  resources :usuarios do
    get :password_change
    patch :password_update
  end

  namespace :admin do
    resources :home_admin
    resources :administrador
    resources :fabricantes
    resources :componentes
    resources :layout_controles
    resources :usuarios do
      get :index_all, on: :collection
    end
    resources :grupos do
      resources :usuarios do
        get :remover, on: :member
      end
      resources :ambientes, shallow: true do
        resources :componentes_ambiente
      end
    end
    resources :controles do
      resources :comandos_infra_vermelhos, shallow: true
    end
  end

  namespace :home do
    get :console
    post :mode_on
    post :mode_off
  end

  require 'sidekiq/web'
  require 'sidekiq-scheduler/web'
  if Rails.env.production?
    Sidekiq::Web.use Rack::Auth::Basic do |username, password|
      ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_USERNAME'])) &
        ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['SIDEKIQ_PASSWORD']))
    end
  end
  mount Sidekiq::Web, at: '/filas'
end
