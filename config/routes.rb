Rails.application.routes.draw do
  devise_for :users, skip: [:unlocks, :passwords, :mailer, :confimations]
  root to: "homes#top"
  resources :users do
    member do
      get "leave_page"
      patch "leave"
    end
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
  end
  resources :chats, only: [:show, :create]
  resources :spots, only: [:index, :show]
  resources :reviews, only: [:create, :destroy]
end
