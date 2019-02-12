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


  scope  module: 'api/v1/sessions' do
    post :session_new
  end

  scope  module: 'api/v1/registrations' do
    post :registration_new
  end

  resources :grupos do
    resources :usuarios
    resources :ambientes_grupo do
      resources :componentes_ambiente, shallow: true do
        resources :layout_controles, shallow: true
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions do
        post :reset_password, on: :collection
      end
      resources :registrations
      namespace :usuarios_grupo do
        post :add_usuario_grupo
        post :destroy_usuario_grupo
        post :set_admin_usuario_grupo
      end
      namespace :mqtt do
        post :publish
      end
      namespace :grupos do
        get :get_grupos
        post :new_grupo
        post :edit_grupo
        post :destroy_grupo
      end
      namespace :ambientes do
        post :new_ambiente
        post :edit_ambiente
        post :destroy_ambiente
      end
      namespace :componentes_ambiente do
        get :get_componentes_ambiente
        post :new_componente_ambiente
        post :edit_componente_ambiente
        post :destroy_componente_ambiente
      end
    end
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
    resources :ambientes
    resources :componentes do
      resources :componentes_propriedades, shallow: true
    end
    resources :layout_controles
    resources :usuarios do
      get :index_all, on: :collection
      resources :tokens_notificacao_mobile, shallow: true
    end
    resources :grupos do
      resources :automacoes_grupo, shallow: true do
        resources :automacoes_grupo_condicoes, shallow: true do
          post :update_componente_propriedades, on: :collection
        end
        resources :automacoes_grupo_acoes, shallow: true
      end
      resources :usuarios do
        get :remover, on: :member
      end
      resources :ambientes_grupo, shallow: true do
        resources :componentes_ambiente
      end
    end
    resources :controles do
      resources :controle_comandos, shallow: true
    end
  end

  namespace :root do
    get :index
  end

  namespace :home do
    get :console
    get :portfolio
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
