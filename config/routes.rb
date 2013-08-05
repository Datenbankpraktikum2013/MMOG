Mmog::Application.routes.draw do

  resources :shipcounts

  resources :battlereports

  resources :messages

  resources :shipfleets

  resources :fleets

  resources :missions

  resources :ships

  resources :buildingtypes

  resources :technologies

  devise_for :users #not needed any more, :controllers => { :registrations => "users/registrations"}

  root 'welcome#index'

  resources :alliances

  resources :ranks, :except => :show
  
  resources :buildings

  resources :galaxies

  resources :sunsystems

  resources :planets

  post 'alliances/:id/edit/change_default_rank' => 'alliances#change_default_rank'

  get 'alliances/:id/edit/useradd' => 'alliances#useradd'

  post 'alliances/:id/edit/user_add_action' => 'alliances#user_add_action'

  post 'alliances/:id/edit/change_user_rank' => 'alliances#change_user_rank'

  post 'alliances/:id/edit/remove_user' => 'alliances#remove_user'

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
