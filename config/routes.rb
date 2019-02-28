Rails.application.routes.draw do
  root "boards#index"
  
  devise_for :users

  resources :boards do
    resources :lists
  end

  resources :lists, except: [:index, :create] do
    resources :tasks
  end
end
