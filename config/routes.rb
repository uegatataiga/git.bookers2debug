Rails.application.routes.draw do

  devise_for :users
  root to: "homes#top"
  get "home/about"=>"homes#about", as: "about"
  resources :books, only: [:index,:show,:edit,:create,:destroy,:update] do
  resource :favorites, only: [:create, :destroy]
  resources :book_comments, only: [:create, :destroy]
  end
  get "search" => "searches#search"
  get 'tagsearches/search', to: 'tagsearches#search'


  resources :users, only: [:index,:show,:edit,:update] do
            member do
            get :follows, :followers
            end
            resource :relationships, only: [:create, :destroy]
  end

end
