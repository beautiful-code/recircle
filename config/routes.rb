Rails.application.routes.draw do
  get 'notifications/index'

  devise_for :users, path_names: {sign_in: "login"},controllers: {omniauth_callbacks:'omniauth_callbacks'}

  root 'app#index'
  get 'search' => 'app#search'


  resources :users,only: [:show]  do
    get 'address' => 'users#address'
    get 'shared_books' => 'users#shared_books'
    patch 'update_address' => 'users#update_address'
    resources :books,only: [:new,:show,:edit,:update, :create] do

      get 'pickup_time' => 'books#pickup_time'
      patch 'lock'
      patch 'unlock'
      patch 'give_back'
    end
    resources :requests, only: [:create, :index] do
      member do
        patch 'accept'
        patch 'decline'
        patch 'cancel'
      end
    end
    resources :notifications,only:[:index] do
      member do
        patch 'read'
      end
    end

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
end
