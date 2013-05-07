Rungteng::Application.routes.draw do

  get "/index" => "staticpage#index"
  get "/home" => "staticpage#home"
  get "/about" => "staticpage#about"
  get "/technology" => "staticpage#technology"
  get "/product" => "staticpage#product"
  get "/link" => "staticpage#link"
  get "/orders" => redirect("http://longtermyeast.anow.com.tw/index.php")

  resources :news, :only => [:index, :show]
  # resources :orders, :only => [:index, :create]
  # match '/orders/calculate' => 'orders#calculate', :via => :post
  # match '/order_check' => 'orders#order_check'
  # match '/order_finish' => 'orders#order_finish'

  resources :products, :only => [:show]

  match "/admin/createAdmin" => "admin#createAdmin", :via => :post
  match "/admin/loginCheck" => "admin#loginCheck", :via => :post
  match "/admin/update" => "admin#update", :via => :put

  namespace :admin do
    get "sign_up", "log_in", "log_out", "edit"
    get '/' => 'news#index'
    
    resources :news, :except => :new do
      match 'uploadPhoto' => 'news#createPhoto', :via => [:post]
      match 'deletePhoto/:id' => 'news#destroyPhoto', :via => [:delete]
    end

    resources :products
    get '/boxs' => "products#index_box"
    get '/boxs/new' => "products#new_box"
    get '/boxs/:id' => "products#show_box"
    match '/boxs' => 'products#create_box', :via => [:post]
    match '/boxs/:id/edit' => 'products#edit_box', :via => [:put]
    resources :orders, :only => [:index, :show, :update, :destroy]
  end

  root :to => "staticpage#index"

end
