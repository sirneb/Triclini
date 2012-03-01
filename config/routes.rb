Triclini::Application.routes.draw do
  match '', to: 'clubs#show', constraints: lambda { |r| r.subdomain.present? && r.subdomain != 'www' }
  root :to => 'clubs#index'

  resources :clubs
  resources :halls 
  resources :dashboard, :only => :index
  resources :reservations, :except => :destroy
  scope 'reservations_show' do
    match '/current', :to => 'reservations_show#current', :as => 'reservations_show_current'
    match '/past', :to => 'reservations_show#past', :as => 'reservations_show_past'
  end
  scope 'reservations_make' do
    match '', :to => 'reservations_make#index', :as => 'reservations_make'
  end
  scope 'search' do
    match '/reservation', :to => 'search#reservation', :as => 'search_reservation'
    match '/member', :to => 'search#customer', :as => 'search_customer'
    match '/event', :to => 'search#event', :as => 'search_event'
  end
  match '/calendar', :to => 'event_calendar#index'

  namespace 'configure' do
    scope '/preferences' do
      match '/club', :to => 'preferences#club'
      match '/hall', :to => 'preferences#hall'
      match '/dining', :to => 'preferences#dining'
      match '/event', :to => 'preferences#event'
    end
    match '/schedules', :to => 'schedules#index'
    match '/accounts', :to => 'accounts#index'
    match '/reservations', :to => 'reservations#index'
  end
  #
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
