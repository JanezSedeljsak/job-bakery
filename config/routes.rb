Rails.application.routes.draw do
  resources :answers
  resources :questions
  resources :candidates
  resources :areas
  resources :locations
  resources :jobs
  devise_for :users
  root to: "base#index"
  #get '/apply', to: 'candidates#apply'
  get '/jobs/applicatns/:id', to: 'jobs#applicants'
  get '/profile/:id', to: 'base#profile'
  get  '/jobs/apply/:id', to: 'candidates#new'
  mount Commontator::Engine => '/commontator'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
