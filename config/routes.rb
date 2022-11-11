Rails.application.routes.draw do

  root to: "homes#top"
  get "/home/about" => "homes#about"

  devise_for :members, skip: [:passwords], controllers: {
  registrations: "public/registrations",
  sessions: "public/sessions"
}
  devise_for :admins, skip: [:passwords, :registrations] ,controllers: {
  sessions: "admin/sessions"
}

  scope module: :public do
    resources :posts, only: [:index,:show,:create,:edit,:update,:destroy]
    resources :bookmarks, only: [:index,:destroy,:create]
    resources :spots, only: [:edit,:update,:destroy]
    resources :reviews, only: [:index,:create,:update,:destroy]
    resources :searches, only: [:get]
    # ここからmembersのルーティング
      get "members/my_page" => "customers#show", as: "my_page"
      get "members/my_page/edit" => "customers#edit", as: "edit"
      patch "members/members" => "customers#update", as: "update"
       # 退会確認画面
      get 'members/unsubscribe' => 'customers#unsubscribe', as: 'unsubscribe'
      # 論理削除用のルーティング
      patch 'members/withdraw' => 'customers#withdraw', as: 'withdraw'
    # ここまでmembersのルーティング
  end

  namespace :admin do
    get "/home/top" => "homes#top"
    resources :members, only: [:index,:show,:edit,:update]
    resources :posts, only: [:index,:show,:destroy]
    resources :spots, only: [:index,:show,:edit,:update,:destroy]
    resources :reviews, only: [:index,:destroy]
    resources :searches, only: [:get]

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
