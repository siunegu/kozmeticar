Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users
  
  root 'products#index'

  
  resources :reservations
  
  resources :products do
    collection do
      get 'categoried/:category_id', to: 'products#index', as: :categoried
    end
  end

end
