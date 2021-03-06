
Rails.application.routes.draw do

  resources :movies do
    member do
      get 'like'
      get 'hate'
      get 'user_movies'
    end
  end
    root 'movies#index'

  match 'users_show/:id' => 'users_show#show', via: :get
  match 'users_show_liked/:id' => 'users_show#show_liked', via: :get
 

  get 'about' => 'pages#about'

  devise_for :users
 

  post   '/like',   to: 'likes#create'
  delete '/like',  to: 'likes#destroy'
  match 'users' => 'errors#index', via: :all

  match 'users/*' => 'errors#index', via: :all
  match '*path' => 'errors#index', via: :all
end

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

