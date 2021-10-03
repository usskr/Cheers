Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  get "/about" => "homes#about"
  resources :users
  resources :posts do
    resources :post_comments, only: [:create, :destroy]
    resource :cheers, only: [:create, :destroy]
  end
end
