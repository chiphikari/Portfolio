Rails.application.routes.draw do
  root to: 'homes#top'
  get '/about' => 'homes#about'
  get '/search' => 'searchs#search'

  devise_for :users
  resources :users, only: %i[show edit update] do
    member do
      get 'unsubscribe'
      patch 'withdraw'
    end
  end

  resources :post_summaries do
    collection do
      get :house
      get :outside
    end
    resources :reviews, only: %i[create destroy]
    resource :bookmarks, only: %i[create destroy]
    resource :favorites, only: %i[create destroy]
  end

end
