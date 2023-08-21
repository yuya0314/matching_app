require 'rails_helper'

RSpec.describe 'Top', type: :system do
  describe 'トップページの動作' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_event) { FactoryBot.create(:second_event) }
    let!(:event_listings) do
      FactoryBot.create_list(:event_listing, 9, user: user, event: event).tap do |listings|
        listings.each_with_index do |event_listing, index|
          event_listing.update(title: "イベントタイトル#{index + 1}")
        end
      end
    end
    let!(:second_event_listing) { FactoryBot.create(:second_event_listing, user: second_user, event: second_event) }

    include_context 'logged in user'

    before do
      visit root_path
    end

    it "ユーザー名をクリックし、ユーザー詳細ページへ遷移すること" do
      all_links = all('a', text: user.name)
      all_links.each_with_index do |link, index|
        link.click
        expect(current_path).to eq user_path(user)
      end
    end

    it "募集イベントの開催日が表示されること" do
      expect(page).to have_content event.date.strftime("%m/%d")
    end

    it "募集イベントの開始時間が表示されること" do
      expect(page).to have_content event.start_time.strftime("%H:%M")
    end

    it "募集イベントの場所が表示されること" do
      expect(page).to have_content event.location
    end

    it "募集イベント日が表示されること" do
      expect(page).to have_content event_listings.first.title
    end

    it "募集イベント開始時間が表示されること" do
      expect(page).to have_content event_listings.first.user.name
    end

    it "募集イベントの8つ目が取得されていること" do
      expect(page).to have_content event_listings[7].title
    end

    it "event_listing検索できること" do
      select "巨人", from: "対戦チーム"
      select "バンテリンドーム", from: "野球場"
      fill_in "q[date_gteq]", with: Date.today.strftime("%Y-%m-%d")
      fill_in "q[date_lteq]", with: (Date.today + 15.days).strftime("%Y-%m-%d")
      click_button "検索"
      expect(page).to have_content event_listings[8].title
      expect(page).not_to have_content second_event_listing.title
    end

    it "second_event_listingを検索できること" do
      select "広島", from: "q[match_eq]"
      select "マツダスタジアム", from: "q[location_eq]"
      fill_in "q[date_gteq]", with: Date.today.strftime("%Y-%m-%d")
      fill_in "q[date_lteq]", with: (Date.today + 13.days).strftime("%Y-%m-%d")
      click_button "検索"
      expect(page).to have_content second_event_listing.title
      expect(page).not_to have_content event_listings[0].title
    end
  end
end
