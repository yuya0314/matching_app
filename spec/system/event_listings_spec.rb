require 'rails_helper'

RSpec.describe 'EventListings', type: :system do
  describe '募集詳細ページの動作' do
    context "イベントに参加していないユーザーがログインした場合" do
      let(:event) { FactoryBot.create(:event) }
      let(:event_listing) { FactoryBot.create(:event_listing, event: event) }
      let!(:user) { FactoryBot.create(:not_registered_user) }

      include_context 'logged in user'

      before do
        visit event_event_listing_path(event,event_listing)
      end

      it "参加できること" do
        fill_in 'event_registration[comment]', with: '楽しみにしています！'
        click_button '参加する'
        expect(page).to have_content 'このイベントに参加しました'
      end
    end

    context "イベントに参加しているユーザーがログインした場合" do
      let!(:event_listing_user) { FactoryBot.create(:user) }
      let(:event) { FactoryBot.create(:event) }
      let(:event_listing) { FactoryBot.create(:event_listing, user: event_listing_user, event: event) }
      let(:user) { FactoryBot.create(:second_user) }
      let!(:event_registration) { FactoryBot.create(:event_registration, user: user, event_listing: event_listing) }

      include_context 'logged in user'
  
      before do
        visit event_event_listing_path(event,event_listing)
      end
  
      it "参加をキャンセルできること" do
        click_on '参加をキャンセル'  
        expect(page).to have_content 'イベントへの参加をキャンセルしました'
        expect(page).to have_selector('input[type="submit"][value="参加する"]')
      end
      
      it "参加者名をクリックした際、そのユーザーの詳細に遷移すること" do
        click_on user.name
        expect(current_path).to eq user_path(user)
      end
    end

    context "イベントを作成しているユーザーがログインした場合" do
      let!(:user) { FactoryBot.create(:user) }
      let(:event) { FactoryBot.create(:event) }
      let(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }
  
      include_context 'logged in user'
    
      before do
        visit event_event_listing_path(event,event_listing)
      end
      
      it "ボタンが参加済と表示されること" do
        expect(page).to have_selector('input[type="submit"][value="参加済"]')
      end

      it "ホームへ戻るをクリックした際、トップページへ遷移すること" do
        click_on 'ホームへ戻る'  
        expect(current_path).to eq root_path
      end

      it "投稿編集をクリックした際、投稿編集ページへ遷移すること" do
        click_on '投稿編集'  
        expect(current_path).to eq edit_event_event_listing_path(event,event_listing)
      end

      it "投稿削除をクリックした際、イベントを削除できること" do
        click_on '投稿削除'  
        expect(page).to have_content '投稿を削除しました'
        expect(EventListing.exists?(event_listing.id)).to be_falsey
      end
    end
  end

  describe '募集編集ページの動作' do
    let!(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }

    include_context 'logged in user'

    before do
    visit edit_event_event_listing_path(event,event_listing)
    end
    
    it "編集できること" do
    fill_in 'event_listing[capacity]', with: '4'
    choose "無"
    fill_in 'event_listing[deadline]', with: Date.today + 10.days
    fill_in 'event_listing[title]', with: '気軽にご参加ください！'
    fill_in 'event_listing[message]', with: '最近ファンになりました！パリーグはオリックスを応援しています'
    click_button '投稿する'
    expect(page).to have_content '投稿内容を更新しました。'
    expect(page).to have_content '気軽にご参加ください'
    expect(page).to have_content 'チケット無'
    expect(page).to have_content '最近ファンになりました！パリーグはオリックスを応援しています'
    expect(page).to have_content '募集人数4人'
    end
  end
end
