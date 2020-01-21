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
