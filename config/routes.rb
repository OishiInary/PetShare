Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :pets, only:[:index, :show, :edit, :update, :destroy] 
  
  get "homes/entrance" => "homes#entrance"
  
end
