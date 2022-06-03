Rails.application.routes.draw do
  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
        mount BrowseEverything::Engine => '/browse'

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

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  # Import
  # ========================================================
  get '/import'              => 'import#index',             as: 'import_index'

  # JSON Imports
  # ========================================================
  resources :json_imports, only: [:index, :show, :new, :create]
  post 'json_imports/preview', as: 'preview_json_import'
  get 'json_imports/preview', to: redirect('json_imports/new')
  get 'json_imports/:id/log', to: 'json_imports#log'
  get 'json_imports/:id/report', to: 'json_imports#report'

  # require 'sidekiq/web'
  # require 'sidekiq/cron/web'
  mount Sidekiq::Web => '/sidekiq'
  # config/routes.rb
  # authenticate :user, lambda { |u| u.admin? } do
  #   mount Sidekiq::Web => '/sidekiq'
  # end  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
