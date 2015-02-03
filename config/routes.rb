Rails.application.routes.draw do

  # routes config for devise
  devise_for :users, skip: :registrations
  devise_scope :user do
    resource :registration,
             only: [:new, :create, :edit, :update],
             path: 'users',
             path_names: { new: 'sign_up' },
             controller: 'registrations',
             as: :user_registration do
      get :cancel
    end
  end
  # routes for extend user
  get 'users/profile' => 'profile#show', as: 'user_profile'

  # routes config for app
  root 'home#index'

  resources :illustrations, except: [:index]
  get 'users/:id/illustrations' => 'illustrations#index', as: 'user_illustrations'
  get 'illustration/:id/download/:style' => 'illustrations#download', as: 'download_illustration'
end
