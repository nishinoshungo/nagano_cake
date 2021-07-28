Rails.application.routes.draw do
  devise_for :admin, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
  }
  devise_for :customers, controllers: {
    sessions:      'customers/sessions',
    passwords:     'customers/passwords',
    registrations: 'customers/registrations'
  }

  get '/admin', to: 'admin/homes#top'
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
  end

  get '/customers/my_page', to: 'public/customers#show'
  get '/customers/edit', to: 'public/customers#edit'
  patch '/customers', to: 'public/customers#update'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe'
  patch '/customers/withdraw', to: 'public/customers#withdraw'

end
