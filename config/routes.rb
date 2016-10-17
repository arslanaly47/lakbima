Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  get 'home/index'
  get 'home/minor'
  root 'home#index'
end
