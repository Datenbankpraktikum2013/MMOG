Mmog::Application.routes.draw do

  resources :ship_building_queues

  resources :receiving_reports #kommt spaeter noch raus

  resources :relationships, :except => [:edit,:update,:show,:create]
  
  resources :techstages #kommt spaeter noch raus

  resources :reports, only: [:show, :index, :destroy]

  resources :shipcounts #kommt spaeter noch raus

  resources :messages, :except => [:edit, :update]

  resources :shipfleets #kommt spaeter noch raus

  resources :fleets #EXCEPT muss hier noch rein!

  resources :missions

  resources :ships

  resources :buildingtypes

  resources :technologies, :except => [:edit, :update, :create, :new, :destroy, :show]

  devise_for :users #not needed any more, :controllers => { :registrations => "users/registrations"}

  root 'welcome#index'

  resources :alliances, :except => [:update, :new]

  resources :ranks, :except => [:show, :index]
  
  resources :buildings

  resources :galaxies

  resources :sunsystems

  resources :planets

  resources :impressum

  post "requests" => "requests#create"
  post "requests/reaction"=>"requests#reaction"
  get "starport" => "starport#index"

  get "starport/:id" => "starport#show"
  

  post "starport/build" => "starport#build"
  get "ship_building_queues/destroy_queue/:id" => "ship_building_queues#destroy_queue"

  post 'alliances/:id/edit/change_default_rank' => 'alliances#change_default_rank'

  get 'json/fetch_unread_msgs' => 'messages#fetch_unread_msgs'

  put 'alliances/:id/edit/change_user_rank' => 'alliances#change_user_rank'

  post 'alliances/:id/edit/remove_user' => 'alliances#remove_user'

  put 'alliances/:id/edit/change_description' => 'alliances#change_description'

  post 'alliances/:id/edit/send_mail' => 'alliances#send_mail'

  post 'technologies/upgrade' => 'technologies#upgrade'

  post 'technologies/show_index' => 'technologies#show_index'

  post 'technologies/abort' => 'technologies#abort'

  get 'json/page_refresh' => 'technologies#page_refresh'

  get '/json/distance' => 'missions#get_distance'
  get '/json/fleetships' => 'missions#get_ships'
  get '/json/check' => 'missions#check_mission'
  get '/json/breakup' => 'fleets#breakup'
  get '/json/unload' => 'fleets#unload'

  get '/confirm/send' => 'missions#send_fleet'

  post 'planets/upgrade_building' => 'planets#upgrade_building'

  get 'alliances_overview' => 'alliances#overview'

  get 'useroverview' => 'useroverview'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
