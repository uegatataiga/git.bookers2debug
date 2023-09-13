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


  resources :groups, except: [:destroy] do
    resource :group_users, only: [:create, :destroy]
    get "new/mail" => "groups#new_mail"
    get "send/mail" => "groups#send_mail"
   end

  resources :users, only: [:index,:show,:edit,:update] do
            member do
            get :follows, :followers
            end
            resource :relationships, only: [:create, :destroy]
  end

  resources :users, only: [:show,:edit,:update]
  resources :messages, only: [:create]
  resources :rooms, only: [:create,:show]


end
