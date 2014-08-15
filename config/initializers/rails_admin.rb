RailsAdmin.config do |config|

  class RailsAdmin::Config::Fields::Types::Uuid < RailsAdmin::Config::Fields::Base
    RailsAdmin::Config::Fields::Types::register(self)
  end

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  config.authenticate_with do
    warden.authenticate! scope: :user

    redirect_to main_app.root_path unless warden.user.admin?
  end
  config.current_user_method(&:current_user)

  config.model 'Product' do
    edit do
      field :name
      field :cover, :carrierwave
      field :available_at
      field :employee
      field :description
      field :price
      field :category
      field :is_promoted
      field :reservation_slots
      field :reservations_count
      field :versions
    end
  end

  config.model 'Reservation' do
    show do
      field :available_at
      field :user
      field :product
      field :is_canceled
      field :created_at
    end
    
    edit do
      field :user
      field :product
      field :is_canceled
      field :versions
    end
  end

  config.model 'User' do
    edit do
      field :firstname
      field :lastname
      field :email
      field :password
      field :password_confirmation
      field :reset_password_sent_at
      field :admin
      field :remember_created_at
      field :sign_in_count
      field :current_sign_in_at
      field :last_sign_in_at
      field :current_sign_in_ip
      field :last_sign_in_ip
      field :versions
      field :products
      field :reservations
      field :visits
    end
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0
  config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
