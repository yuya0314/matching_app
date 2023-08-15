require 'rails_helper'

RSpec.describe 'ChatRooms', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:second_user) { FactoryBot.create(:second_user) }
  let!(:chat_room) { FactoryBot.create(:chat_room, user: user, second_user: second_user) }
  let!(:chat_message) { FactoryBot.create(:chat_message, chat_room: chat_room) }
  let!(:chat_second_message) { FactoryBot.create(:chat_second_message, chat_room: chat_room) }

  include_context 'logged in user'

  before do
    visit chat_room_path(chat_room)
  end

  it 'チャット相手名が表示されること' do
    expect(page).to have_content second_user.name
  end

  it "チャット相手の画像が表示されること" do
    expect(page).to have_selector("img[src$='#{second_user.profile_image.url}']")
  end

  it "チャットページを取得されること" do
    expect(page).to have_content 'チケット私が買ってもいいですか？'
  end

  it "チャットページを取得されること" do
    expect(page).to have_content 'すみません、よろしくお願いします。外野がいいです。'
  end
end
