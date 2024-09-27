class Public::ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :block_non_related_users, only: [:show]
  before_action :ensure_correct_user, only: [:edit, :update]
  # チャットルームの表示
  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    unless user_rooms.nil?
      @room = user_rooms.room
    else
      @room = Room.create # ルームを作成
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
      UserRoom.create(user_id: @user.id, room_id: @room.id)
    end

   @chats = @room.chats.order(created_at: :desc).limit(10) # 最新の10件を取得
    @chat = Chat.new(room_id: @room.id)
  end
  
  def load_more
  @chats = Chat.where(room_id: params[:room_id]).order(created_at: :desc).offset(params[:offset]).limit(10)
  render partial: 'public/chats/chat', collection: @chats, as: :chat
  end


  # チャットメッセージの送信
  def create
    @chat = current_user.chats.new(chat_params)
  
    if @chat.save
      respond_to do |format|
        format.js   # JSリクエストが来た場合の処理
        # format.htmlの処理は実行されないように注意する
      end
    else
      respond_to do |format|
        format.js   { render "public/chats/validater.js.erb" }
      end
    end
  end


  # チャットメッセージの削除
  def destroy
    @chat = current_user.chats.find(params[:id])
    @chat.destroy
    respond_to do |format|
      format.js # 削除後の処理を非同期で行う
    end
  end

  private

  # フォームから送信されたパラメータを安全に取得
  def chat_params
    params.require(:chat).permit(:message, :room_id, :image) # 画像も許可
  end

  # 関連のないユーザーをブロックするメソッド
  def block_non_related_users
    @user = User.find(params[:id])
    unless current_user.following?(@user) && @user.following?(current_user)
      redirect_to user_path(@user)
    end
  end
end
