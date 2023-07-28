class AddReferencesToChatRoomUsers < ActiveRecord::Migration[6.1]
  def change
    add_reference :chat_room_users, :chat_room, null: false, foreign_key: true
    add_reference :chat_room_users, :user, null: false, foreign_key: true
  end
end
