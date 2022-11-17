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
      resources :post_comments, only: [:create]
    end
  end
  # ここからmembersのルーティング
  get "members/my_page" => "members#show", as: "my_page"
  get "members/my_page/edit" => "members#edit", as: "edit"
  patch "members/members" => "members#update", as: "update"
   # 退会確認画面
  get 'members/unsubscribe' => 'members#unsubscribe', as: 'unsubscribe'
  # 論理削除用のルーティング
  patch 'members/withdraw' => 'members#withdraw', as: 'withdraw'
  resources :members, only: [:show] do
    member do
    get :bookmarks
  end

end

  namespace :admin do
    resources :members, only: [:index,:show,:edit,:update]
    resources :posts, only: [:index,:show,:destroy] do
      resources :reviews, only: [:index,:destroy]
      resources :comments, only: [:destroy]
    end
    resources :tags, only: [:new, :create, :index, :edit, :destroy]
  end


devise_scope :user do
  post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
end

end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

