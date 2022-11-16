Rails.application.routes.draw do

  root to: "public/posts#index"
  get "/home/about" => "homes#about"

  devise_for :members, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
}
  devise_for :admins, skip: [:passwords, :registrations] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    resources :posts, only: [:new,:index,:show,:create,:edit,:update,:destroy] do
      resources :bookmarks, only: [:index,:destroy,:create]
      resources :reviews, only: [:index,:create,:update,:destroy]
    end
    resources :searches, only: [:get]
    # ここからmembersのルーティング
    get "members/my_page" => "customers#show", as: "my_page"
    get "members/my_page/edit" => "customers#edit", as: "edit"
    patch "members/members" => "customers#update", as: "update"
     # 退会確認画面
    get 'members/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
    # 論理削除用のルーティング
    patch 'members/withdraw' => 'customers#withdraw', as: 'withdraw'
    resources :members, only: [:show] do
      member do
      get :bookmarks
    end
  end
  end

  namespace :admin do
    resources :members, only: [:index,:show,:edit,:update]
    resources :posts, only: [:index,:show,:destroy] do
      resources :reviews, only: [:index,:destroy]
    end
    resources :tags, only: [:new, :create, :index, :edit, :destroy]
    resources :searches, only: [:get]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
