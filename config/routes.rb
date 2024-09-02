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
    resources :users, only:[:index, :show, :edit, :update]
    resources :categories, only:[:new, :index, :show, :create, :edit, :update, :destroy]
    resources :albums, only:[:index, :show, :edit, :update, :destroy]
    resources :groups, only:[:index, :show, :edit, :update, :destroy]
    resources :rooms, only:[:index, :show, :edit, :update, :destroy]
    get "/" => "homes#top"
  end
  
  scope module: :public do
    root to: "homes#top"
    get "homes/entrance" => "homes#entrance", as: "entrance"
    get "homes/save"  => "homes#save", as: "save"
    get "homes/about" => "homes#about", as: "about"
    get "homes/mypage" => "homes#mypage", as: "mypage"
    resources :categories, only:[:index, :show]
    resources :users, only:[:index, :show, :edit, :update,]do
      resource :relationships, only: [:create,:destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers"  => "relationships#followers",  as: "followers"
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
