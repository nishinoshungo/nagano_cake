Rails.application.routes.draw do

  devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, skip: 'registrations', controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }
  devise_scope :customer do
    get '/customers/sign_up', to: 'customers/registrations#new', as: :new_customer_registration
    post 'customers', to: 'customers/registrations#create'
  end

  get '/admin', to: 'admin/homes#top'
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
  end

  patch '/admin/orders/:order_id/order_items/:id', to: 'admin/order_items#update'

  get '/customers/my_page', to: 'public/customers#show'
  get '/customers/edit', to: 'public/customers#edit'
  patch '/customers', to: 'public/customers#update'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'

  get '/addresses', to: 'public/addresses#index'
  get '/addresses/:id/edit', to: 'public/addresses#edit', as: :edit_address
  post '/addresses', to: 'public/addresses#create'
  patch '/addresses/:id', to: 'public/addresses#update'
  delete '/addresses/:id', to: 'public/addresses#destroy', as: :destroy_address

  get '/items', to: 'public/items#index'
  get '/items/:id', to: 'public/items#show', as: :item
  get '/search', to: 'public/items#search'

  get '/cart_items', to: 'public/cart_items#index'
  patch '/cart_items/:id', to: 'public/cart_items#update'
  delete '/cart_items/:id', to: 'public/cart_items#destroy'
  delete '/cart_items', to: 'public/cart_items#destroy_all'
  post '/cart_items', to: 'public/cart_items#create'

  get '/orders/new', to: 'public/orders#new'
  post '/orders/confirm', to: 'public/orders#confirm'
  get '/orders/complete', to: 'public/orders#complete'
  post '/orders', to: 'public/orders#create'
  get '/orders', to: 'public/orders#index'
  get '/orders/:id', to: 'public/orders#show'
end
