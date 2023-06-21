Rails.application.routes.draw do
  mount Bulkrax::Engine, at: '/'
  mount Riiif::Engine => 'images', as: :riiif if Hyrax.config.iiif_image_server?
  mount BrowseEverything::Engine => '/browse'

  mount Blacklight::Engine => '/'
  
  concern :searchable, Blacklight::Routes::Searchable.new

  resource :catalog, only: [:index], as: 'catalog', path: '/catalog', controller: 'catalog' do
    concerns :searchable
  end

  mount Samvera::Persona::Engine => '/'

  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  mount Hydra::RoleManagement::Engine => '/'

  mount Qa::Engine => '/authorities'
  mount Hyrax::Engine, at: '/'
  mount HydraEditor::Engine => '/'
  resources :welcome, only: 'index'
  root 'hyrax/homepage#index'
  curation_concerns_basic_routes
  concern :exportable, Blacklight::Routes::Exportable.new

  require 'sidekiq/web'
  require 'sidekiq/cron/web'
  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  resources :solr_documents, only: [:show], path: '/catalog', controller: 'catalog' do
    concerns :exportable
  end

  resources :bookmarks do
    concerns :exportable

    collection do
      delete 'clear'
    end
  end

  mount PdfjsViewer::Rails::Engine => "/pdfjs", as: 'pdfjs'
  resources :checksums, :only => [ :index, :create, :update ]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
