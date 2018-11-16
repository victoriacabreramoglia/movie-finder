Rails.application.routes.draw do
  get 'error/timeline'
  get 'critics/index'
  get 'critics/show'
  get 'movie/show'
  get 'movie/index'
  get 'dashboard', to: "dashboard#home"
  get 'dashboard/movies', to: "dashboard#movies"
  get 'dashboard/critics', to: 'dashboard#critics'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root to: 'home#index'
  get 'home/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
