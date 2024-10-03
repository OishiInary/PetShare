Rails.application.routes.draw do

  devise_for :admin, controllers: {
  sessions: "admin/sessions"
}
  # 一般ユーザー用デバイス
  devise_for :users,skip: [:password],controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # 新規会員登録でエラーが出たときにusersにURLが変わっていることへの対処
  get "users" => redirect("/users/sign_up")

  devise_scope :user do
    post "user/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  namespace :admin do
    root to: "homes#top"
    resources :users, only:[ :show, :index, :edit, :update]
    resources :pets, only:[:show,:index,:destroy]do
        resources :albums, only: [] do
         collection do
          get 'load_more', to: 'albums#load_more_albums'
          end
       end
     end
    resources :categories, only:[:new,:show,:index, :create, :edit, :update, :destroy]
    resources :albums, only:[:show,:index,:destroy]do
      resources :comments, only:[:destroy]
    end
    resources :tags, only:[:index, :destroy]
    resources :rooms, only:[:show,:index, :edit, :update, :destroy]
    resources :groups, only:[:show,:index,:edit,:update,:destroy] do
      resources :group_users, only:[:destroy]
         resources :group_chats, only:[:destroy]
    end


  end

  scope module: :public do
    root to: "homes#top"
    get "/search" => "searches#search"
    get "homes/entrance" => "homes#entrance", as: "entrance"
    get "homes/save"  => "homes#save", as: "save"
    get "homes/guide" => "homes#guide", as: "guide"
    get "homes/about" => "homes#about", as: "about"
    get "homes/mypage" => "homes#mypage", as: "mypage"
    get "homes/my_album" => "homes#my_album", as: "my_album"
    get "homes/my_pet" => "homes#my_pet", as: "my_pet"
    get "homes/follow_list" => "homes#follow_list", as: "follow_list"
    get "homes/f_albums" => "homes#f_albums", as: "f_albums"
    get "homes/f_pets" => "homes#f_pets", as: "f_pets"
    patch "users/withdraw" => "users#withdraw", as: "withdraw"
    get "users/unsubscribe" => "users#unsubscribe", as: "unsubscribe"
    resources :chats, only: [:show, :create, :destroy]
    resources :categories, only:[:index, :show]
    resources :users, only:[:index, :show, :edit, :update,]do
      resource :relationships, only: [:create,:destroy]
        get "followings" => "relationships#followings", as: "followings"
        get "followers"  => "relationships#followers",  as: "followers"
    end
    resources :pets, only:[:show, :index, :new, :create, :edit, :update, :destroy]do
      resource :pet_favorites, only:[:create, :destroy]
    end

    resources :albums, only:[:index, :show, :new, :create, :edit, :update, :destroy]do
      resources :comments, only:[:create,:destroy]
          resource :favorites, only:[:create, :destroy]
    end

    resources :groups, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resources :group_users, only:[:create, :destroy]
         resources :group_chats, only:[:create, :destroy]
    end
      resources :tags, only:[:index, :show] 
  end
end
