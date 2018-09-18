Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :subs do
    resources :posts, only: [:create]
  end

  resource :session, only: [:new, :create, :destroy]
  resources :posts, only: [:new, :destroy, :show, :edit, :update]
end
