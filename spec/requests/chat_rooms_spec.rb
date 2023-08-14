require 'rails_helper'

RSpec.describe "ChatRooms", type: :request do
  describe "GET /chat_rooms/show" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:third_user) { FactoryBot.create(:not_registered_user) }
    let!(:chat_room) { FactoryBot.create(:chat_room, user: user, second_user: second_user) }
    let!(:chat_message) { FactoryBot.create(:chat_message, chat_room: chat_room) }
    let!(:chat_second_message) { FactoryBot.create(:chat_second_message, chat_room: chat_room) }

    context 'ログインした場合' do
      before do
        sign_in user
        get chat_room_path(chat_room)
      end

      it "チャットページを取得されること" do
        expect(response).to have_http_status(200)
      end

      it "チャットページを取得されること" do
        expect(response.body).to include second_user.name
      end

      it "チャットページを取得されること" do
        expect(response.body).to include second_user.profile_image.url
      end

      it "チャットページを取得されること" do
        expect(response.body).to include 'チケット私が買ってもいいですか？'
      end

      it "チャットページを取得されること" do
        expect(response.body).to include 'すみません、よろしくお願いします。外野がいいです。'
      end
    end

    context '他のユーザーがアクセスする場合' do
      it '他のユーザーがアクセスした場合、トップページに遷移すること' do
        sign_in third_user
        get chat_room_path(chat_room)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(root_path)
        expect(flash[:error]).to eq '参照権限がありません。'
      end
    end
  end
end
