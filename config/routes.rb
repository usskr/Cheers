Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "/about" => "homes#about"
  resources :users do
    resource :relationships, only: [:create, :destroy]
    get "followings" => "relationships#followings", as: "followings"
    get "followers" => "relationships#followers", as: "followers"
  end
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :cheers, only: [:create, :destroy]
    collection do
      get :search
    end
    # collection do
    #   get :rank
    # end
  end
  resources :chats, only: [:show, :create]
  resources :spots, only: [:index, :show]
end
