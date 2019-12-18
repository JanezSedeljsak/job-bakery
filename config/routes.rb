Rails.application.routes.draw do
  resources :applicants
  resources :areas
  resources :locations
  resources :jobs
  resources :applicants
  devise_for :users
  root to: "base#index"
  get '/apply', to: 'applicants#apply'
  get '/jobs/applicatns/:id', to: 'jobs#applicants'
  get '/profile', to: 'profile#index'
  mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
