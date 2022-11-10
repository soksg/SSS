Rails.application.routes.draw do
  devise_for :members ,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  devise_for :admins ,skip: [:passwords, :registrations] ,controllers: {
    sessions: "admin/sessions"
  }
  
    namespace :public do
    get 'posts/index'
    get 'posts/show'
    get 'posts/create'
    get 'posts/edit'
    get 'posts/update'
    get 'posts/destroy'
  end
  
  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
