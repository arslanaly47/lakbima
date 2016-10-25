Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords" }
  resources :employees, :job_titles, :currencies, :allowance_types, :vacation_types, :roles, :accounts

  resources :departments do
    member do
      get 'job_titles'
    end
  end

  get 'users/new' => 'users/manages#new'
  get 'home/index'
  get 'home/minor'
  root 'employees#index'
end
