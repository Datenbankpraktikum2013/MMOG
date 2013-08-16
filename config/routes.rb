Mmog::Application.routes.draw do

  resources :ship_building_queues , :except => [:edit, :update, :create, :new, :show]

  resources :receiving_reports #kommt spaeter noch raus

  resources :relationships, :except => [:edit,:update,:show,:create]
  
  resources :techstages #kommt spaeter noch raus

  resources :reports, only: [:show, :index, :destroy]

  resources :shipcounts #kommt spaeter noch raus

  resources :messages, :except => [:edit, :update]

  resources :shipfleets #kommt spaeter noch raus

  resources :fleets , :except => [:edit, :update, :create, :new, :destroy, :show]

  resources :missions

  resources :ships , :except => [:edit, :update, :create, :new, :destroy, :show]

  resources :buildingtypes

  resources :technologies, :except => [:edit, :update, :create, :new, :destroy, :show]

  devise_for :users #not needed any more, :controllers => { :registrations => "users/registrations"}

  root 'welcome#index'

  resources :alliances, :except => [:update, :new]

  resources :ranks, :except => [:show, :index]
  
  resources :buildings

  resources :galaxies

  resources :sunsystems

  resources :planets, :except => [:edit, :update, :create, :new, :destroy, :index]



  post "requests" => "requests#create"
  post "requests/reaction"=>"requests#reaction"
  get "starport" => "starport#index"

  get "starport/:id" => "starport#show"
  

  post "starport/build" => "starport#build"
  get "ship_building_queues/destroy_queue/:id" => "ship_building_queues#destroy_queue"

  post 'alliances/:id/edit/change_default_rank' => 'alliances#change_default_rank'

  #get 'json/fetch_unread_msgs' => 'messages#fetch_unread_msgs'
  get 'json/fetch' => 'json_fetch#fetch'

  put 'alliances/:id/edit/change_user_rank' => 'alliances#change_user_rank'

  post 'alliances/:id/edit/remove_user' => 'alliances#remove_user'

  put 'alliances/:id/edit/change_description' => 'alliances#change_description'

  post 'alliances/:id/edit/send_mail' => 'alliances#send_mail'

  post 'technologies/upgrade' => 'technologies#upgrade'

  post 'technologies/show_index' => 'technologies#show_index'

  post 'technologies/abort' => 'technologies#abort'

  get 'json/page_refresh' => 'technologies#page_refresh'
  get 'json/planet_page_refresh' => 'planets#page_refresh'

  get '/json/distance' => 'missions#get_distance'
  get '/json/fleetships' => 'missions#get_ships'
  get '/json/check' => 'missions#check_mission'
  get '/json/breakup' => 'fleets#breakup'
  get '/json/unload' => 'fleets#unload'
  get '/json/info' => 'missions#get_info'

  get '/confirm/send' => 'missions#send_fleet'

  post 'planets/upgrade_building' => 'planets#upgrade_building'
  post 'planets/abort_upgrade' => 'planets#abort_upgrade'
  post 'planets/rename_planet' => 'planets#rename_planet'
  post 'planets/set_home_planet' => 'planets#set_home_planet'
  #post 'planets/redirect_to_planet' => 'planets#redirect_to_planet'


  post '/alliances/:id/leave' => 'alliances#leave'

  post '/alliances/:id/change_founder' => 'alliances#change_founder'

  get 'alliances_overview' => 'alliances#overview'

  delete 'flush_inbox' => 'messages#flush_inbox'
  delete 'flush_outbox' => 'messages#flush_outbox'

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
