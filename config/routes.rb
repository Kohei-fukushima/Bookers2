Rails.application.routes.draw do
 devise_for :users
 root to:'homes#top'
 get '/home/about' => 'homes#about',as:"about"
 get "search" => "searches#search"
 resources :books,only:[:new,:create,:index,:show,:destroy,:edit,:update] do
   resource :favorites, only:[:create,:destroy]
   resources :book_comments,only:[:create, :destroy]
end

 resources :users,only:[:show,:edit,:index,:update] do
  resource :relationships, only: [:create, :destroy]
  get :followings, on: :member
  get :followers, on: :member


 end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
