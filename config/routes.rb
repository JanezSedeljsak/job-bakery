Rails.application.routes.draw do
  resources :candidates
  resources :areas
  resources :locations
  resources :jobs
  devise_for :users
  root to: "base#index"
  get '/apply', to: 'candidates#new'
  get '/jobs/applicatns/:id', to: 'jobs#applicants'
  get '/profile', to: 'profile#index'
  mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
