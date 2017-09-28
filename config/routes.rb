Rails.application.routes.draw do

  resources :componentes
  root 'home#index'

  devise_for :usuarios, controllers: {
   confirmations: 'confirmations'
  }
  as :usuario do
    #get 'usuarios/edit' => 'devise/registrations#edit', :as => 'edit_usuario_registration'
   # put 'usuarios' => 'devise/registrations#update', :as => 'usuario_registration'
    patch "/confirm" => "confirmations#confirm"
  end

  devise_for :admin, controllers: {
    sessions: 'admin/devise/sessions'
  }

  get '/usuarios' => redirect('/usuarios/sign_in')
  get '/admin' => redirect('/admin/sign_in')

  resources :grupos do
    resources :usuarios
    resources :ambientes do
      resources :componentes
    end
  end

  namespace :api do
    namespace :request do
      post :google_api_request
    end
    namespace :componentes do
      post :publish
    end
  end

  resources :usuarios do
    get :password_change
    patch :password_update
  end

  namespace :admin do
    resources :home_admin
    resources :administrador
    resources :usuarios do
      get :index_all, on: :collection
    end
    resources :grupos do
      resources :usuarios do
        get :remover, on: :member
      end
      resources :ambientes, shallow: true do
        resources :componentes, shallow: true do
          resources :comandos_infra_vermelhos, shallow: true
        end
      end
    end
    resources :controles_componentes
  end

  namespace :home do
    get :console
    post :mode_on
    post :mode_off
  end

end
