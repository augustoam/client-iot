Rails.application.routes.draw do
  root 'home#index'

  mount ActionCable.server => '/cable'

  devise_for :users, controllers: {
    confirmations: 'confirmations'
  }
  as :user do
    patch '/confirm' => 'confirmations#confirm'
  end

  devise_for :admin, controllers: {
    sessions: 'admin/devise/sessions'
  }

  get '/users' => redirect('/users/sign_in')
  get '/admin' => redirect('/admin/sign_in')

  scope  module: 'api/v1/sessions' do
    post :session_new
  end

  scope  module: 'api/v1/registrations' do
    post :registration_new
  end

  resources :groups do
    resources :users
    resources :group_rooms do
      resources :room_devices, shallow: true do
        resources :control_layouts, shallow: true
      end
    end
  end

  namespace :api do
    namespace :v1 do
      resources :sessions do
        post :reset_password, on: :collection
      end
      resources :registrations
      namespace :users_group do
        post :add_user_group
        post :destroy_user_group
        post :set_admin_user_group
      end
      namespace :mqtt do
        post :publish
      end
      namespace :groups do
        get :get_groups
        post :new_group
        post :edit_group
        post :destroy_group
      end
      namespace :rooms do
        post :new_room
        post :edit_room
        post :destroy_room
      end
      namespace :room_devices do
        get :get_room_devices
        post :new_room_device
        post :edit_room_device
        post :destroy_room_device
      end
    end
    namespace :request do
      post :google_api_request
    end
    namespace :devices do
      post :publish
      post :recebe_estado
    end
  end

  namespace :api do
    namespace :v2 do
      resources :sessions do
        post :reset_password, on: :collection
      end
      resources :registrations
      namespace :groups do
        get :get_groups
        post :new_group
        post :edit_group
        post :destroy_group
      end
    end
  end

  resources :users do
    get :password_change
    patch :password_update
  end

  namespace :admin do
    resources :home_admin
    resources :administrador
    resources :manufacturers
    resources :rooms
    resources :devices
    resources :control_layouts
    resources :users do
      get :index_all, on: :collection
      resources :notification_tokens, shallow: true
    end
    resources :groups do
      resources :group_automations, shallow: true do
        resources :group_automation_conditions, shallow: true
        resources :group_automation_actions, shallow: true
      end
      resources :users do
        get :remover, on: :member
      end
      resources :group_rooms, shallow: true do
        resources :room_devices
      end
    end
    resources :controls do
      resources :control_commands, shallow: true
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
