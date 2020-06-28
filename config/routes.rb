Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/transcript-manual', to: 'pages#transcript'
  resources :transcripts do
    get '/transcript-manual', to: 'pages#transcript', as: 'exec'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
