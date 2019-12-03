Rails.application.routes.draw do
  resources :jobs
  devise_for :users
  root to: "base#index"
  mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
