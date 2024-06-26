Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:index] do
      get 'generate_orders_csv', on: :member
    end
    get 'users/:username/download_csv', to: 'users#download_csv'
  end

  mount ActionCable.server => '/cable'
end
