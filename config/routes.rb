Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    get 'welcome', to: 'welcome#index'
    get 'health', to: 'health#index'
    resources :posts
  end
end
