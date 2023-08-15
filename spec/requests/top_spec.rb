require 'rails_helper'

RSpec.describe "Top", type: :request do
  describe "GET root_path" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_listings) do
      FactoryBot.create_list(:event_listing, 9, user: user, event: event).tap do |listings|
        listings.each_with_index do |event_listing, index|
          event_listing.update(title: "イベントタイトル#{index + 1}")
        end
      end
    end

    context "ページネーションの1ページ目" do
      before do
        get root_path
      end

      it "トップページが取得されること" do
        expect(response).to have_http_status(200)
      end

      it "イベント日が取得されること" do
        expect(response.body).to include event.date.strftime("%m/%d")
      end

      it "イベント開始時間が取得されること" do
        expect(response.body).to include event.start_time.strftime("%H:%M")
      end

      it "イベント場所が取得されること" do
        expect(response.body).to include event.location
      end

      it "ユーザー名が取得されること" do
        expect(response.body).to include event_listings.first.user.name
      end

      it "イベントタイトルが取得されること" do
        expect(response.body).to include event_listings.first.title
      end

      it "募集中が取得されること" do
        expect(response.body).to include "募集中"
      end

      it "ページネーションの2が取得されること" do
        expect(response.body).to include "2"
      end

      it "イベントの8つ目が取得されていること" do
        expect(response.body).to include event_listings[7].title
      end

      it "イベントの9つ目が取得されていないこと" do
        expect(response.body).not_to include event_listings[8].title
      end

      it "チームの選択肢が正確に表示されること" do
        Event::TEAMS.each do |team|
          expect(response.body).to include(team)
        end
      end

      it "場所の選択肢が正確に表示されること" do
        Event::LOCATIONS.each do |location|
          expect(response.body).to include(location)
        end
      end

      it "検索が取得されること" do
        expect(response.body).to include "検索"
      end
    end

    context "ページネーションの2ページ目" do
      before do
        get root_path(page: 2)
      end

      it "トップページが取得されること" do
        expect(response).to have_http_status(200)
      end

      it "関連する商品が8つ取得されていること" do
        expect(response.body).to include event_listings[8].title
      end

      it "8番目の商品は取得されていないこと" do
        expect(response.body).not_to include event_listings[7].title
      end
    end
  end
end
