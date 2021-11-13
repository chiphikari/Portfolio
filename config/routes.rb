Rails.application.routes.draw do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/search' => 'searchs#search'

    devise_for :users
    resources :users
    get '/users/withdraw' => 'users#withdraw'
    patch '/users/withdraw' => 'users#withdraw'

    resources :post_summaries do
        collection do
            get :house
            get :outside
        end
        resources :reviews, only: [:create, :destroy]
        resource :bookmarks, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
    end


    devise_for :admins
end
