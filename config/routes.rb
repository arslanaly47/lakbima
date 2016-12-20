Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  devise_for :users, controllers: { sessions: "users/sessions", passwords: "users/passwords" }
  resources :job_titles, :currencies, :allowance_types, :vacation_types, :roles, :attachment_types, :roles, :branches, :accounts

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
  resources :journal_entries, only: [:index] do
    collection do
      get :build_options
    end
  end
  delete 'journal_entry_sessions/:id/close' => 'journal_entry_sessions#close', as: :close_journal_entry_session
  resources :account_main_types, path: "account_headers", only: [:show, :edit, :update, :index] do
    member do
      get 'account_sub_headers'
    end
  end
  resources :account_sub_types, path: "account_sub_headers" do
    member do
      get 'account_lists'
    end
  end
  resources :account_types, path: "account_lists"
  get 'profile' => 'users#profile'
  patch 'update_profile' => 'users#update_profile'
  resources :dynamic_menus do
    collection do
      get 'to_account_type_ids/:from_account_type_ids' => 'dynamic_menus#to_account_type_ids'
    end
  end
end
