Rails.application.routes.draw do
    root to: 'homes#top'
    get 'home/about' => 'homes#about'

    devise_for :users
    resources :users
    get '/users/withdraw' => 'users#withdraw'
    patch '/users/withdraw' => 'users#withdraw'

    resources :post_summaries do
        collection do
            get :house
            get :outside
        end
        resources :reviews, only: [:index, :create, :show]
    end


    devise_for :admins
end
