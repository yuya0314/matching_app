require 'rails_helper'

RSpec.describe "EventListings", type: :request do
  describe "GET event/event_listing/show" do
    let!(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }
    let(:second_user) { FactoryBot.create(:second_user) }
    let!(:event_registration) { FactoryBot.create(:event_registration, user: second_user, event_listing: event_listing) }
    let!(:not_registered_user) { FactoryBot.create(:not_registered_user) }

    context "ログインしていない場合" do
      before do
        get event_event_listing_path(event,event_listing)
      end

      it "募集詳細ページを取得されること"  do
        expect(response).to have_http_status(200)
      end

      it "イベント日が取得されること" do
        expect(response.body).to include event.date.strftime("%m/%d")
      end

      it "対戦チームが取得されること" do
        expect(response.body).to include event.match
      end

      it "イベント開始時間が取得されること" do
        expect(response.body).to include event.start_time.strftime("%H:%M")
      end

      it "イベント場所が取得されること" do
        expect(response.body).to include event.location
      end

      it "タイトルが取得されること" do
        expect(response.body).to include event_listing.title
      end

      it "メッセージが取得されること" do
        expect(response.body).to include event_listing.message
      end

      it "締切が取得されること" do
        deadline_display = "締切  #{event_listing.deadline.strftime("%m/%d")}"
        expect(response.body).to include deadline_display
      end

      it "募集人数が取得されること" do
        expect(response.body).to include event_listing.capacity.to_s
      end

      it "チケットの有無が取得されること" do
        ticket_status = event_listing.has_ticket ? "チケット有" : "チケット無"
        expect(response.body).to include ticket_status
      end

      it "参加コメントが取得されること" do
        expect(response.body).to include event_registration.comment
      end

      it "参加者の名前が取得されること" do
        expect(response.body).to include event_registration.user.name
      end
    end

    context "イベント投稿者がログインした場合" do
      before do
        sign_in user
        get event_event_listing_path(event,event_listing)
      end

      it "投稿編集リンクが表示されること" do
        expect(response.body).to include '投稿編集'
      end

      it "投稿削除リンクが表示されること" do
        expect(response.body).to include '投稿削除'
      end

      it "参加ボタンが'参加済'と表示されること" do
        expect(response.body).to include '参加済'
      end
    end

    context "イベント参加者がログインした場合" do
      before do
        sign_in second_user
        get event_event_listing_path(event,event_listing)
      end

      it "参加ボタンが'参加をキャンセル'と表示されること" do
        expect(response.body).to include '参加をキャンセル'
      end
    end

    context "イベントに参加していないユーザーがログインした場合" do
      before do
        sign_in not_registered_user
        get event_event_listing_path(event,event_listing)
      end

      it "参加ボタンが'参加する'と表示されること" do
        expect(response.body).to include '参加する'
      end

      it "参加できること" do
        post "/event_registrations", params: { event_registration: {event_listing_id: event_listing.id,comment: "チケットは私が用意します"} }
        follow_redirect!
        expect(response.body).to include "このイベントに参加しました"
      end
    end
  end

  describe "GET event/event_listing/edit" do
    let!(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }
    let(:second_user) { FactoryBot.create(:second_user) }
    
    context "投稿者以外はアクセスできないこと" do
      it "投稿者でないユーザーはアクセスできないこと" do
        sign_in second_user
        get edit_event_event_listing_path(event, event_listing)
        expect(response).to have_http_status(:redirect) 
        expect(response).to redirect_to(root_path)
        follow_redirect!
        expect(response.body).to include "投稿者のみ実行できます。"
      end

      it "ログインしていないユーザーはアクセスできないこと" do
        get edit_event_event_listing_path(event, event_listing)
        expect(response).to have_http_status(:redirect) 
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "投稿者がログインした場合の表示" do
      before do
        sign_in user
        get edit_event_event_listing_path(event, event_listing)
      end

      it "対戦チームが取得されること" do
        expect(response.body).to include event.match
      end

      it "イベント開始時間が取得されること" do
        expect(response.body).to include event.start_time.strftime("%H:%M")
      end

      it "イベント場所が取得されること" do
        expect(response.body).to include event.location
      end

      it "タイトルが取得されること" do
        expect(response.body).to include event_listing.title
      end

      it "メッセージが取得されること" do
        expect(response.body).to include event_listing.message
      end

      it "締切が取得されること" do
        expect(response.body).to include event_listing.deadline.to_s
      end

      it "募集人数が取得されること" do
        expect(response.body).to include event_listing.capacity.to_s
      end

      it "チケットの有無が取得されること" do
        expect(response.body).to include event_listing.has_ticket.to_s
      end

      it "編集できること" do
        expect(response.body).to include "男女問わず参加してください！"
        patch event_event_listing_path(event, event_listing), params: { event_listing: {title: "気軽にご参加ください！"} }
        follow_redirect!
        expect(response.body).to include "投稿内容を更新しました。"
        expect(response.body).to include "気軽にご参加ください！"
        expect(response.body).to_not include "男女問わず参加してください！"
      end
    end
  end
end
