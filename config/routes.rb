Rails.application.routes.draw do
  get 'searches/index'
  get 'searches/search'
  get 'likes/create'
  get 'likes/destroy'
  get 'create/destroy'
  get 'post_comments/new'
  get 'post_comments/create'
  get 'post_comments/edit'
  get 'post_comments/update'
  get 'post_comments/destroy'
  devise_for :users
  resources :posts do
  	resource :post_comments, only: [:create, :destroy]
  	resource :likes, only: [:create, :destroy]
  end
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
