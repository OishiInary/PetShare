Rails.application.routes.draw do
  #管理者用デバイス
  devise_for :admin, skip: [:registrations, :passwords],contolloers:{
    registrations: 'admin/sessions'
  }
  # 一般ユーザー用デバイス
  devise_for :users,skip: [:password],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  
    
  namespace :admin do
    resources :users, only:[ :show, :index, :edit, :update]
    resources :categories, only:[:new,:show,:index, :create, :edit, :update, :destroy]
    resources :albums, only:[:show,:index, :edit, :update, :destroy]
    resources :groups, only:[:show,:index, :edit, :update, :destroy]
    resources :rooms, only:[:show,:index, :edit, :update, :destroy]
    get "/" => "homes#top"
  end
  
  scope module: :public do
    root to: "homes#top"
    get "homes/entrance" => "homes#entrance", as: "entrance"
    get "homes/save"  => "homes#save", as: "save"
    get "homes/about" => "homes#about", as: "about"
    get "homes/mypage" => "homes#mypage", as: "mypage"
    get "homes/my_album" => "homes#my_album", as: "my_album"
    get "homes/follow_list" => "homes#follow_list", as: "follow_list"
    patch "users/withdraw" => "users#withdraw", as: "withdraw"
    get "users/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    resources :categories, only:[:index, :show]
    resources :users, only:[:index, :show, :edit, :update,]do
      resource :relationships, only: [:create,:destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers"  => "relationships#followers",  as: "followers"
        get "users/follow_list" => "users/follow_list", as: "follow_list"
    end
    resources :pets, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resource :pet_favorites, only:[:create, :destroy]
    end

    resources :groups, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resources :group_chat, only:[:create, :destroy]
    end
    
    resources :albums, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resources :comments, only:[:create, :update, :destroy]
          resource :favorites, only:[:create, :destroy]
    end  
    
    resources :rooms, only:[:create, :show]do
      resources :messages, only:[:create]
    end

  end

  
end
