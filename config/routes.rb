Rails.application.routes.draw do
  
  root 'home#index'
  get '/usuarios' => redirect('/usuarios/sign_in')

  devise_for :usuarios, controllers: { 
   sessions:      'usuarios/devise/sessions',
   registrations: 'usuarios/devise/registrations',
   confirmations: 'usuarios/devise/confirmations',
   passwords:     'usuarios/devise/passwords' 
  }

  resources :grupos_usuarios
  
  resources :home do
    get :publish, on: :collection
    get :subscribe, on: :collection
  end
end
