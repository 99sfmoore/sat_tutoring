SatApp::Application.routes.draw do
  resources :sites do
    resources :group_meetings
    resources :students, only: [:index]
    resources :tutors, only: [:index]
    member do
      get :site_admin
      get :contact
      get :import_answers
      post :load_answers
      get :enter_scores
      post :entered_scores
      get :score_summary
    end
    resources :registration_tickets, only: [:new, :create]
  end

  resources :students do 
    resources :homeworks do
      member do
        get :check_homework
        post :checked_homework
        get :send_hints
        post :send_email
      end
    end
    resources :tests, only: [:show] 
    resources :scores, only: [:index]
    

    collection do 
      post :load_answers
      post :test_score
    end
    member do
      get :enter_answers
      post :entered_answers
      get :check_homework
      post :checked_homework
      get :hit_try_matrix
      get :send_test
      get :scaled_scores
    end
  end
  resources :tests do
    resources :segments do
      resources :students do
        get :segment_performance
      end
      resources :tutors do
        get :segment_performance
      end
    end
    resources :students do
      resources :categories, only:[:show]
    end
  end
  resources :tutors do
    resources :lesson_plans, only:[:index]
    resources :tests, only: [:show]
    member do
      get :show_scores
    end
  end
  resources :answers 
  resources :sessions, only: [:new, :create, :destroy]
  resources :sections do
    member do
      get :edit_questions
      post :update_questions
    end
  end

  resources :group_meetings do
    resources :tutors do
      resources :lesson_plans, only: [:new, :create]
    end
  end

  resources :lesson_plans, only: [:show, :edit, :update] do
    member do
      get :homework_sheet
    end
  end

  resources :hw_hints, only: [:edit, :update]

  resources :questions do
    resources :hw_hints, only: [:new, :create]
    resources :assignments do
      resources :hw_hints, only: [:index] do
        collection do
          post :choose_hint
        end
      end
    end
  end


   

  root 'static_pages#home'
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'

  


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
