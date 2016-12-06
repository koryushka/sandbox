Rails.application.routes.draw do

  use_doorkeeper
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    get 'welcome', to: 'welcome#index'
    get 'health', to: 'health#index'
    resources :posts do
      resources :images
    end
    resources :images, only: [:destroy, :update]
  end
end
