Rails.application.routes.draw do
  resources :notifications
  resources :feeds, :only => [:index] do
    collection do
      get 'search', to: "feeds#search"
    end
  end
  resources :post_categories
  resources :views
  resources :partners
  resources :pages
  resources :conversations
  resources :friends
  resources :shares
  resources :likes
  resources :comments
  resources :posts do
    collection do
      get "categories/:category_name", to: "posts#index"
    end
    member do
      put "like", to: "posts#like"
      put "upvote", to: "posts#upvote"
      put "downvote", to: "posts#downvote"
      put "pin", to: "posts#pin"
      post "comment", to: "posts#comment"
    end
  end
  get "deals", to: "posts#deals"
  resources :tags
  resources :profiles do
    member do
      put "friend", to: "profiles#friend"
      put "partner", to: "profiles#partner"
    end
  end
  devise_for :users
  root to: "feeds#index"
  resources :categories
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
