Rails.application.routes.draw do
  devise_for :users
  resources :projects, only: [:index, :show, :create, :update, :destroy] do
    resources :users, only: [:index] do
      get 'to_add', on: :collection
      post 'add_to_project'
      delete 'remove_from_project'
    end
    resources :roles, only: [:index, :create] do
      post 'mark_as_default'
    end
    resources :sprints, only: [:index, :create] do
      get 'closed', on: :collection
      post 'start'
    end
    resources :notebooks, only: [:index, :create] do 
      post 'mark_as_default'
    end
    resources :events, only: [:index, :create]
    resources :stories, only: [:index, :create]
  end  
  resources :roles, only: [:update, :destroy]
  resources :sprints, only: [:show, :update, :destroy] do
    resources :retrospectives, only: [:create, :index]
  end
  resources :retrospectives, only: [:update, :show, :destroy]
  resources :notebooks, only: [:show, :update, :destroy] do
    delete 'remove_all_notes'
    resources :notes, only: [:index, :create, :update, :destroy] do
      post 'move_to_trash'
    end
  end
  resources :events, only: [:update, :destroy]
  resources :stories, only: [:update, :destroy]

  root to: 'application#index'
  get '*path' => 'application#index'

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
