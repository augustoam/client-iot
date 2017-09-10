Rails.application.routes.draw do

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
  end

  resources :usuarios
  
  resources :ambientes

  namespace :admin do
    resources :home_admin
    resources :grupos do
      resources :usuarios do
        get :remover, on: :member
      end
      resources :ambientes
    end
  end

  resources :home do
    get :console, on: :collection
    get :publish, on: :collection
    get :subscribe, on: :collection
  end

end
