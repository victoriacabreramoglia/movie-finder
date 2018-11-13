Rails.application.routes.draw do
  get 'critics/index'
  get 'critics/show'
  get 'movie/show'
  get 'movie/index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
