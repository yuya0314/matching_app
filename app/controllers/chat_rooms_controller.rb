class ChatRoomsController < ApplicationController
  before_action :authenticate_user!, only: [:show, :create]
  before_action :ensure_user_can_access_chat_room, only: [:show]

  def show
    @chat_room = ChatRoom.find(params[:id])
    @chat_room_user = @chat_room.chat_room_users.where.not(user_id: current_user.id).first.user
    @chat_messages = ChatMessage.where(chat_room: @chat_room)
  end

  def create
    current_user_chat_rooms = ChatRoomUser.where(user_id: current_user.id).map(&:chat_room)
    chat_room = ChatRoomUser.where(chat_room: current_user_chat_rooms,
                                   user_id: params[:user_id]).map(&:chat_room).first
    if chat_room.blank?
      chat_room = ChatRoom.create
      ChatRoomUser.create(chat_room: chat_room, user_id: current_user.id)
      ChatRoomUser.create(chat_room: chat_room, user_id: params[:user_id])
    end
    redirect_to action: :show, id: chat_room.id
  end

  private

  def ensure_user_can_access_chat_room
    @chat_room = ChatRoom.find(params[:id])
    unless @chat_room.chat_room_users.map(&:user).include?(current_user)
      flash[:error] = '参照権限がありません。'
      redirect_to root_path
    end
  end
end
