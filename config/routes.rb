Rails.application.routes.draw do
  get 'home/index'
  get 'home/minor'
  root 'home#index'
end
