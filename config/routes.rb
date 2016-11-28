Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords" }
  resources :job_titles, :currencies, :allowance_types, :vacation_types, :roles, :accounts, :attachment_types, :roles, :branches

  resources :leave_applications, except: [:edit, :update, :destroy] do
    member do
      post 'approve'
      post 'deny'
    end
  end
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
  resources :users, only: [:edit] do
    collection do
      patch 'update_password'
      get   'check_uniqueness'
    end
  end
  resources :notifications, only: [:index] do
    member do
      post 'mark_as_read'
    end
  end
  resources :journal_entry_sessions, only: [:create] do
    resources :journal_entries, only: [:index, :create, :update, :destroy, :show]
  end
  get 'profile' => 'users#profile'
  patch 'update_profile' => 'users#update_profile'
end
