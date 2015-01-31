Rails.application.routes.draw do

  devise_for :users

  root 'home#index'

  resources :illustrations, except: [:index]
  get 'users/:id/illustrations' => 'illustrations#index', as: 'user_illustrations'
  get 'illustration/:id/download/:style' => 'illustrations#download', as: 'download_illustration'
end
