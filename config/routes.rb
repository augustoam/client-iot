Rails.application.routes.draw do

  root 'home#index'
  get '/usuarios' => redirect('/usuarios/sign_in')

  devise_for :usuarios, controllers: { 
   sessions:      'usuarios/devise/sessions',
   registrations: 'contas',
   confirmations: 'usuarios/devise/confirmations',
   passwords:     'usuarios/devise/passwords' 
  }
  as :usuario do
    put 'update_usuario_confirmation_path' => 'usuarios/devise/confirmations#update',   :as => 'update_confirmations'
  end

  resources :grupos do
    resources :grupos_usuarios
  end

  resources :contas
  
  resources :grupos_usuarios

  resources :home do
    get :publish, on: :collection
    get :subscribe, on: :collection
  end
end
