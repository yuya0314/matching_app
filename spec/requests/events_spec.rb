require 'rails_helper'

RSpec.describe "Events", type: :request do
  describe "GET /index" do
    let(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_future) { FactoryBot.create(:event, date: Date.today + 5.days) }
    let!(:event_past) { FactoryBot.create(:event, date: Date.today - 5.days) }

    context "ログインしていない場合" do
      it "イベント一覧が取得できないこと" do
        get "/events/"
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインした場合" do
      before do
        sign_in user
        get "/events/"
      end

      it "イベント一覧ページが取得できること" do
        expect(response).to have_http_status(200)
      end

      it "イベント日が取得されること" do
        expect(response.body).to include event.date.strftime("%m/%d")
      end

      it "イベント開始時間が取得されること" do
        expect(response.body).to include event.start_time.strftime("%H:%M")
      end

      it "対戦チームが取得されること" do
        expect(response.body).to include event.match
      end

      it "イベント場所が取得されること" do
        expect(response.body).to include event.location
      end

      it "募集ボタンが表示されること" do
        expect(response.body).to include "募集"
      end

      it "過去のイベントは取得されないこと" do
        expect(response.body).not_to include event_past.date.strftime("%m/%d")
      end
    end
  end

  describe "GET /show" do
    let(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }

    context "ログインしていない場合" do
      it "イベント一覧が取得できないこと" do
        get event_path(event)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "ログインした場合" do
      before do
        sign_in user
        get event_path(event)
      end

      it "イベント投稿ページが取得できること" do
        expect(response).to have_http_status(200)
      end

      it "イベント日が取得されること" do
        expect(response.body).to include event.date.strftime("%m/%d")
      end

      it "イベント開始時間が取得されること" do
        expect(response.body).to include event.start_time.strftime("%H:%M")
      end

      it "対戦チームが取得されること" do
        expect(response.body).to include event.match
      end

      it "イベント場所が取得されること" do
        expect(response.body).to include event.location
      end

      it "選択リンクが表示されること" do
        expect(response.body).to include "観戦日選択へ戻る"
      end

      it "投稿ボタンが表示されること" do
        expect(response.body).to include '投稿する'
      end

      it "イベント投稿できること" do
        post event_event_listings_path(event), params: { event_listing: FactoryBot.attributes_for(:event_listing,event_id: event.id) }
        follow_redirect!
        expect(response.body).to include 'イベントを作成しました'
      end
    end
  end

  describe "GET /search" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }

    before do
      get search_events_path
    end

    it "イベント投稿ページが取得できること" do
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

    it "イベント日が取得されること" do
      expect(response.body).to include event_listing.title
    end

    it "イベント開始時間が取得されること" do
      expect(response.body).to include event_listing.user.name
    end

    it "選択リンクが表示されること" do
      expect(response.body).to include "ホームへ戻る"
    end
  end
end
