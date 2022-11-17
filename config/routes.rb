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
      resource :bookmarks, only: [:destroy,:create]
      resources :reviews, only: [:index,:create,:update,:destroy]
      resources :post_comments, only: [:create,:destroy]
    end
    resources :members, only: [:show, :edit, :update] do
      member do
        get :bookmarks
      end
    end
  end
  # ここからmembersのルーティング
   # 退会確認画面
  get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
   # 論理削除用のルーティング
  patch 'members/withdraw' => 'members#withdraw', as: 'withdraw'


  namespace :admin do
    resources :members, only: [:index,:show,:edit,:update]
    resources :posts, only: [:index,:show,:destroy] do
      resources :reviews, only: [:index,:destroy]
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:new, :create, :index, :edit, :destroy]
  end

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

