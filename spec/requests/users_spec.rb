require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /show" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_event_listing) { FactoryBot.create(:second_event_listing, user: second_user) }
    let!(:event_registration) { FactoryBot.create(:event_registration, event_listing: second_event_listing, user: user) }

    context "ログインしていない場合" do
      it "イベント一覧が取得できないこと" do
        get user_path(user)
        expect(response).to have_http_status(:redirect)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "本人がログインしユーザー詳細ページにアクセスした場合" do
      before do
        sign_in user
        get user_path(user)
      end

      it "ユーザー詳細ページが取得できること" do
        expect(response).to have_http_status(200)
      end

      it "ユーザー名が取得されること" do
        expect(response.body).to include user.name
      end

      it "ファン歴が取得されること" do
        expect(response.body).to include user.fan_years.to_s
      end

      it "好きな選手が取得されること" do
        expect(response.body).to include user.favorite_player
      end

      it "自己紹介が取得されること" do
        expect(response.body).to include user.self_introduction
      end

      it "ユーザー編集リンクが表示されること" do
        expect(response.body).to include "ユーザー編集"
      end

      it "募集したイベントの開催日が取得されること" do
        expect(response.body).to include event_listing.event.date.strftime("%m/%d")
      end

      it "募集したイベントの開始時間が取得されること" do
        expect(response.body).to include event_listing.event.start_time.strftime("%H:%M")
      end

      it "募集したイベントの場所が取得されること" do
        expect(response.body).to include event_listing.event.location
      end

      it "募集したイベントのタイトルが取得されること" do
        expect(response.body).to include event_listing.title
      end

      it "募集したイベントの開催者の名前が取得されること" do
        expect(response.body).to include event_listing.user.name
      end

      it "参加したイベントの開催日が取得されること" do
        expect(response.body).to include event_registration.event_listing.event.date.strftime("%m/%d")
      end

      it "参加したイベントの開始時間が取得されること" do
        expect(response.body).to include event_registration.event_listing.event.start_time.strftime("%H:%M")
      end

      it "参加したイベントの場所が取得されること" do
        expect(response.body).to include event_registration.event_listing.event.location
      end

      it "参加したイベントのタイトルが取得されること" do
        expect(response.body).to include event_registration.event_listing.title
      end

      it "参加したイベントの開催者の名前が取得されること" do
        expect(response.body).to include event_registration.event_listing.user.name
      end

      it "DMが表示されないこと" do
        expect(response.body).not_to include "DM"
      end
    end

    context "本人がログインし他のユーザー詳細ページにアクセスした場合" do
      before do
        sign_in user
        get user_path(second_user.id)
      end

      it "ユーザー詳細ページが取得できること" do
        expect(response).to have_http_status(200)
      end

      it "DMが表示されること" do
        expect(response.body).to include "DM"
      end

      it "ユーザー編集リンクが表示されないこと" do
        expect(response.body).not_to include "ユーザー編集"
      end
    end
  end

  describe "GET /edit" do
    let(:user) { FactoryBot.create(:user) }

    before do
      sign_in user
      get "/users/edit"
    end

    it "ユーザー編集ページにアクセスできること" do
      expect(response).to have_http_status(200)
    end

    it "ユーザー名が取得されること" do
      expect(response.body).to include user.name
    end

    it "ファン歴が取得されること" do
      expect(response.body).to include user.fan_years.to_s
    end

    it "好きな選手が取得されること" do
      expect(response.body).to include user.favorite_player
    end

    it "自己紹介が取得されること" do
      expect(response.body).to include user.self_introduction
    end

    it "参加ボタンが'参加する'と表示されること" do
      expect(response.body).to include '保存'
    end
  end
end
