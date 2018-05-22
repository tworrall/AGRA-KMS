Rails.application.routes.draw do
  
  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  mount Blacklight::Engine => '/'
  
    concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  devise_for :users
  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  resources :groups
  resources :group_memberships
  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  get '/users_for_group/:groupid', controller: 'group_memberships', to: 'group_memberships#get_users_for_group'
  get '/user_mgmt/new', controller: 'users', to: 'users#new' 
  post '/user_mgmt/new', controller: 'users', to: 'users#create'
  get '/user_mgmt/edit/:user_id', controller: 'users', to: 'users#admin_edit' 
  patch '/user_mgmt/update', controller: 'users', to: 'users#admin_update'
  delete '/user_mgmt/delete/:user_id', controller: 'users', to: 'users#destroy' 
  get '/user_mgmt/pwd/:user_id', controller: 'users', to: 'users#admin_pwd' 
  patch '/user_mgmt/pwd_update', controller: 'users', to: 'users#admin_pwd_update'
  get '/user_mgmt/pwd_change/:user_id', controller: 'users', to: 'users#user_pwd_change' 
  patch '/user_mgmt/user_pwd_update', controller: 'users', to: 'users#user_pwd_update'

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
