require 'rails_helper'

RSpec.describe 'Event', type: :system do
  describe 'イベント一覧ページの動作' do
    let(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }

    include_context 'logged in user'

    before do
      visit events_path
    end

    it "募集ボタンをクリックし、投稿ページへ遷移すること" do
      click_on '募集'
      expect(current_path).to eq event_path(event)
    end

    it "イベント日が表示されること" do
      expect(page).to have_content event.date.strftime("%m/%d")
    end

    it "イベント開始時間が表示されること" do
      expect(page).to have_content event.start_time.strftime("%H:%M")
    end

    it "対戦チームが表示されること" do
      expect(page).to have_content event.match
    end

    it "イベント場所が表示されること" do
      expect(page).to have_content event.location
    end

    it "募集ボタンが表示されること" do
      expect(page).to have_content "募集"
    end
  end

  describe '投稿ページの動作' do
    let(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }

    include_context 'logged in user'

    before do
      visit event_path(event)
    end

    it "募集ボタンをクリックし、投稿ページへ遷移すること" do
      click_link '観戦日選択へ戻る'
      expect(current_path).to eq events_path
    end

    it "投稿できること" do
      fill_in 'event_listing[capacity]', with: '3'
      choose "有"
      fill_in 'event_listing[deadline]', with: Date.today + 7.days
      fill_in 'event_listing[title]', with: '男女問わず参加してください！'
      fill_in 'event_listing[message]', with: 'ライトスタンドで一緒に熱く応援しましょう！応援歌一緒に歌える方がいいです！'
      click_button '投稿する'
      expect(page).to have_content 'イベントを作成しました'
      expect(page).to have_content '男女問わず参加してください！'
      expect(page).to have_content 'チケット有'
      expect(page).to have_content 'ライトスタンドで一緒に熱く応援しましょう！応援歌一緒に歌える方がいいです！'
      expect(page).to have_content '募集人数3人'
    end

    it "エラーメッセージが表示されること" do
      click_button '投稿する'
      expect(page).to have_content '募集タイトルを入力してください'
      expect(page).to have_content '募集締切を入力してください'
      expect(page).to have_content 'メッセージを入力してください'
      expect(page).to have_content '募集人数(自身除く)を入力してください'
      expect(page).to have_content '募集人数(自身除く)は数値で入力してください'
      expect(page).to have_content 'チケットの有無を入力して下さい'
    end

    it "イベント日が表示されること" do
      expect(page).to have_content event.date.strftime("%m/%d")
    end

    it "イベント開始時間が表示されること" do
      expect(page).to have_content event.start_time.strftime("%H:%M")
    end

    it "対戦チームが表示されること" do
      expect(page).to have_content event.match
    end

    it "イベント場所が表示されること" do
      expect(page).to have_content event.location
    end

    it "選択リンクが表示されること" do
      expect(page).to have_content "観戦日選択へ戻る"
    end

    it "投稿ボタンが表示されること" do
      expect(page).to have_selector('input[type="submit"][value="投稿する"]')
    end
  end

  describe "検索結果画面の動作" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }

    include_context 'logged in user'

    before do
      visit search_events_path
    end
    
    it "ホームへ戻るをクリックし、トップページへ遷移すること" do
      click_link 'ホームへ戻る'
      expect(current_path).to eq root_path
    end
    
    it "募集中をクリックし、募集詳細ページへ遷移すること" do
      click_link '募集中'
      expect(current_path).to eq event_event_listing_path(event,event_listing)
    end
    
    it "ユーザー名をクリックし、ユーザー詳細ページへ遷移すること" do
      click_link event_listing.user.name
      expect(current_path).to eq user_path(user)
    end

    it "イベント日が表示されること" do
      expect(page).to have_content event.date.strftime("%m/%d")
    end

    it "イベント開始時間が表示されること" do
      expect(page).to have_content event.start_time.strftime("%H:%M")
    end

    it "イベント場所が表示されること" do
      expect(page).to have_content event.location
    end

    it "イベント日が表示されること" do
      expect(page).to have_content event_listing.title
    end

    it "イベント開始時間が表示されること" do
      expect(page).to have_content event_listing.user.name
    end

    it "選択リンクが表示されること" do
      expect(page).to have_content "ホームへ戻る"
    end
  end
end
