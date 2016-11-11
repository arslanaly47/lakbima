Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords" }
  resources :employees, :job_titles, :currencies, :allowance_types, :vacation_types, :roles, :accounts, :attachment_types

  resources :departments do
    member do
      get 'job_titles'
    end
  end

  resources :employees do
    member do
      get 'download_attachment/:attachment_id' => 'employees#download_attachment',
        as: :attachment
    end
  end
  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  root 'employees#index'
end
