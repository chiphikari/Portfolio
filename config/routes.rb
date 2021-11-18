Rails.application.routes.draw do
    root to: 'homes#top'
    get '/about' => 'homes#about'
    get '/search' => 'searchs#search'

    devise_for :users
    resources :users, only: [:show, :edit, :update]
    get '/users/:id/withdraw' => 'users#unsubscribe', as: 'unsubscribe'
    patch '/users/:id/withdraw' => 'users#withdraw', as: 'withdraw'

    resources :post_summaries do
        collection do
            get :house
            get :outside
            get :like
        end
        resources :reviews, only: [:create, :destroy]
        resource :bookmarks, only: [:create, :destroy]
        resource :favorites, only: [:create, :destroy]
    end


    devise_for :admins
end
