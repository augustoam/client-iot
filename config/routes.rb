Rails.application.routes.draw do

  root 'home#index'
  get '/usuarios' => redirect('/devise/sign_in')

  devise_for :usuarios, controllers: { 
   confirmations: 'confirmations'
  }
  as :usuario do
    #get 'usuarios/edit' => 'devise/registrations#edit', :as => 'edit_usuario_registration'
   # put 'usuarios' => 'devise/registrations#update', :as => 'usuario_registration'
    patch "/confirm" => "confirmations#confirm"
  end

  resources :grupos do
    resources :usuarios
  end

  resources :usuarios

  resources :home do
    get :publish, on: :collection
    get :subscribe, on: :collection
  end
end
