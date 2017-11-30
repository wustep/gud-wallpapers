# Rails routes
#
# Update(11/22/17):: [Nishad] Added initial wallpapers index route
# Update(11/27/17):: [Stephen] Added omni auth callback & failure
# Update(11/27/17):: [Ben] Added sort order route
# Update(11/28/17):: [Jason] Added show user gallery route
# Update(11/29/17):: [Martin] Added advanced search route

Rails.application.routes.draw do
  # Root: show list of wallpapers
  root 'wallpapers#index'

  # Omniauth routes
  get "/auth/oauth2/callback"   => "auth0#callback"
  get "/auth/failure"           => "auth0#failure"
  get '/logout', to: 'auth0#destroy'

  # User routed
  get '/users/:id/:gallery', to: 'users#show'
  get '/users/:id/', to: 'users#show', :as => :user

  # In wallpapers, allow for different sort orders in first param of URL
  resources :wallpapers, except: [:edit]
  get '/:sortOrder', to: 'wallpapers#index'
  get '/tags/:tag', to: 'wallpapers#tags'


  resources :search
  post '/advsearch', to: 'search#adv_search'

  # Routes for favoriting and unfavoriting
  match 'favorite', to: 'wallpapers#favorite', via: :post
  match 'unfavorite', to: 'wallpapers#unfavorite', via: :delete

  # Route to obtain tags
  put '/wallpapers/:id/updatetags', to: 'wallpapers#update_tags'

  #catch-all for unmatched routes
  get '*unmatched_route', to: 'wallpapers#index'

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
