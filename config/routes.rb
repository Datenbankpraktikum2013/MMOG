Mmog::Application.routes.draw do


  resources :colonisationreports

  resources :travelreports

  resources :ship_building_queues

  resources :receiving_reports

  resources :relationships
  
  resources :techstages

  resources :spyreports

  resources :tradereports

  resources :reports

  resources :shipcounts

  resources :battlereports

  resources :messages, :except => [:edit, :update]

  resources :shipfleets

  resources :fleets

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

  get "starport" => "starport#index"
  get "starport/:id" => "starport#show"
  post "starport/build" => "starport#build"
  get "ship_building_queues/destroy_queue/:id" => "ship_building_queues#destroy_queue"


  post 'alliances/:id/edit/change_default_rank' => 'alliances#change_default_rank'

  get 'json/fetch_unread_msgs' => 'messages#fetch_unread_msgs'

  post 'alliances/:id/edit/user_add_action' => 'alliances#user_add_action'

  put 'alliances/:id/edit/change_user_rank' => 'alliances#change_user_rank'

  post 'alliances/:id/edit/remove_user' => 'alliances#remove_user'

  put 'alliances/:id/edit/change_description' => 'alliances#change_description'

  post 'alliances/:id/edit/send_mail' => 'alliances#send_mail'

  post 'technologies/upgrade' => 'technologies#upgrade'

  post 'technologies/show_index' => 'technologies#show_index'

  post 'technologies/abort' => 'technologies#abort'

  get 'json/page_refresh' => 'technologies#page_refresh'

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
