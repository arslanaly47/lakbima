Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords" }
  resources :employees, :departments, :job_titles, :currencies, :allowance_types

  get 'users/new' => 'users/manages#new'
  get 'home/index'
  get 'home/minor'
  root 'home#index'
end
