Rails.application.routes.draw do
  get 'cart/add_book'

  get 'cart/add_ebook'

  mount Ckeditor::Engine => '/ckeditor'
  #  get 'merchants/new'

  # get 'frontend_pages/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
 
  # -- General Pages --
  get '/sell' => 'frontend_pages#sell' # sellers
  get '/blog' => 'frontend_pages#blog'

  # cart routes
  scope path: '/cart', controller: :cart do
     post 'add-ebook' => :add_ebook
     post 'add-product' => :add_product
     post 'add-book' => :add_book
     post 'delete-item' => :delete_item
     get 'load-cart' => :load_cart
  end

  # categories routes
  get '/categories/:category', to: 'categories#index', constraints: { category: /[A-Za-z0-9-]/ } # get the list of products for a category

  # Products route
  get '/product/:product_title', to: 'frontend_pages#product' #, constraints: { product_title: /[A-Za-z0-9]{50}/ }

  # terms of use
  get '/terms' => 'frontend_pages#terms'

  # -- Stores Routes --
    get '/stores' => 'stores#index'
    post '/stores' => 'stores#create'
  
  # -- Merchants Routes --
    get '/merchants/terms' => 'merchants#terms'
    get '/merchants/login' => 'sessions#new'
    post '/merchants/login' => 'sessions#create'
    delete '/merchants/logout' => 'sessions#destroy'

    post '/merchants/categories' => 'categories#get_sub_categories' #books categories
    post '/merchants/book-description' => 'products#description' #add book description
    post '/merchants/complete-upload' => 'products#complete_upload'

    # merchants products routes
    get '/merchants/products' => 'products#index'
    post '/merchants/products' => 'products#create'
    post '/merchants/upload-cover-image' => 'products#upload_cover_image'
    post '/merchants/upload-epub-file' => 'products#upload_epub_file'

    get '/merchants/sell' => 'merchants#sell' # sell a book
    get '/merchants/signup' => 'merchants#new' # merchants signup link
    get '/merchants/resend-verification-mail' => 'merchants#resend_mail' # resend verification code
    get '/merchants/verify-email/:verification_code', to: 'merchants#verify_email', constraints: { verification_code: /[A-Za-z0-9]{50}/ } # verify email
    resources :merchants # resources generator for merchants

  # You can have the root of your site routed with "root"
  root 'frontend_pages#index'

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
