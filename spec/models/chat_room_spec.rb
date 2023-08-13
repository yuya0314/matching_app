require 'rails_helper'

RSpec.describe ChatRoom, type: :model do
  describe '正常系の機能' do
    let(:user) { FactoryBot.create(:user) }
    let(:second_user) { FactoryBot.create(:second_user) }
    
    it '正しく登録できること' do
      chat_room = ChatRoom.new
      expect(chat_room).to be_valid
      chat_room.save
      chat_room_user = ChatRoomUser.new(chat_room: chat_room, user: user )
      expect(chat_room_user).to be_valid
      chat_room_user.save
      chat_room_second_user = ChatRoomUser.new(chat_room: chat_room, user: second_user )
      expect(chat_room_second_user).to be_valid
      chat_room_second_user.save
      chat_message = ChatMessage.new(
        chat_room: chat_room,
        user: user, 
        content: 'チケット私が買ってもいいですか？'
      )
      expect(chat_message).to be_valid
      chat_message.save
      chat_second_message = ChatMessage.new(
        chat_room: chat_room,
        user: second_user,
        content: 'すみません、よろしくお願いします。外野がいいです。' 
      )
      expect(chat_second_message).to be_valid
      chat_second_message.save
    end
  end
end
