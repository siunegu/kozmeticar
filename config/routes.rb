Rails.application.routes.draw do
  mount Peek::Railtie => '/peek'

  devise_for :users
  
  root 'products#index'

  
  resources :reservations do
    member do
      put :cancel
    end
  end
  
  resources :products, only: [:index, :show] do
    collection do
      get 'categoried/:category_id', to: 'products#index', as: :categoried
    end
  end

  authenticate :user, lambda {|user| user.admin? } do
    get '/admin' => 'admin#index'
    get '/recent-reservations' => "pages#recent_reservations", path: '/admin/recent_reservations'
    resources :broadcast_messages, only: [:create, :destroy], path: '/admin/broadcast_messages'


    mount PgHero::Engine, at: "pghero"
    mount RailsAdmin::Engine => '/admin/rails_admin', as: 'rails_admin'
  end

end
