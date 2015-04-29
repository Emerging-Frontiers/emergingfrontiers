Rails.application.routes.draw do
  devise_for :investors , :controllers => { :omniauth_callbacks => "omniauth_callbacks" ,:sessions => "sessions",:registrations => "registrations"}
  root :to => 'home#index'
  get "/blogs" => "home#blogs",as: :blogs

  get "/investment" => "home#investment", as: :investment
  get "/about" => "home#about", as: :about
  get "/approach" => "home#approach",as: :approach
  get "/legal" => "home#legal", as: :legal
  get "/read_rss_feed" => "home#read_rss_feed", as: :read_rss_feed
  get "/blog/:id/blog_detail" => "home#blog_detail", as: :blog_detail
  post "send_to_mailchimp" => "home#send_to_mailchimp",as: :send_to_mailchimp

  post "/about/contact_us" => "home#contact_us" ,as: :contact_us

  get "investor/analysis" => "investors#analysis", as: :analysis
  post "investor/update_analysis" => "investors#update_analysis", as: :update_analysis
  get "investor/successfull_registration" => "investors#successfull_registration",as: :successfull_registration
  post "mailchimp_registration" => "investors#mailchimp_registration",as: :mailchimp_registration
  get "investment_opportunity_detail/:id" => "investors#investment_opportunity_detail", as: :investment_opportunity_detail
  get "send_investment_email/:id" => "investors#send_investment_email", as: :send_investment_email
  match 'profile' => "investors#edit", :as => :profile, :via => [ :get]
  match 'profile/edit' => "investors#update", :via => [ :put, :patch ], :as => :update_profile
  match 'investors/index' => "investors#index",:via => [:get], :as => :get_investors
  post "investors/delete" => "investors#destroy"
  post "investors/update_investor" => "investors#update_investor"
  post "investors/edit_investor" => "investors#edit_investor"
  get "/tokbox" => "home#tokbox"


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
