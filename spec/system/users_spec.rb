RSpec.describe 'Users', type: :system do
  describe 'ユーザー詳細ページの動作' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:event) { FactoryBot.create(:event) }
    let!(:event_listing) { FactoryBot.create(:event_listing, user: user, event: event) }
    let!(:second_user) { FactoryBot.create(:second_user) }
    let!(:second_event_listing) { FactoryBot.create(:second_event_listing, user: second_user) }
    let!(:event_registration) { FactoryBot.create(:event_registration, event_listing: second_event_listing, user: user) }
    let!(:chat_room) { FactoryBot.create(:chat_room, user: user, second_user: second_user) }

    include_context 'logged in user'

    context "本人がログインしユーザー詳細ページにアクセスした場合" do
      before do
        visit user_path(user)
      end

      it "ユーザー編集リンクをクリックし、投稿ページへ遷移すること" do
        click_link 'ユーザー編集'
        expect(current_path).to eq edit_user_registration_path
      end

      it "ユーザー名をクリックし、ユーザ詳細ページへ遷移すること" do
        click_link event_listing.user.name
        expect(current_path).to eq user_path(user)
      end

      it "募集をクリックし、イベント詳細ページへ遷移すること" do
        all_links = all('a', text: '募集中')
        all_links.each_with_index do |link, index|
          link.click
          expect(current_path).to eq event_event_listing_path(EventListing.all[index].event, EventListing.all[index])
        end
      end

      it "ユーザー名が表示されること" do
        expect(page).to have_content user.name
      end

      it "ファン歴が表示されること" do
        expect(page).to have_content user.fan_years.to_s
      end

      it "好きな選手が表示されること" do
        expect(page).to have_content user.favorite_player
      end

      it "自己紹介が表示されること" do
        expect(page).to have_content user.self_introduction
      end

      it "募集したイベントの開催日が表示されること" do
        expect(page).to have_content event_listing.event.date.strftime("%m/%d")
      end

      it "募集したイベントの開始時間が表示されること" do
        expect(page).to have_content event_listing.event.start_time.strftime("%H:%M")
      end

      it "募集したイベントの場所が表示されること" do
        expect(page).to have_content event_listing.event.location
      end

      it "募集したイベントのタイトルが表示されること" do
        expect(page).to have_content event_listing.title
      end

      it "募集したイベントの開催者の名前が表示されること" do
        expect(page).to have_content event_listing.user.name
      end

      it "参加したイベントの開催日が表示されること" do
        expect(page).to have_content event_registration.event_listing.event.date.strftime("%m/%d")
      end

      it "参加したイベントの開始時間が表示されること" do
        expect(page).to have_content event_registration.event_listing.event.start_time.strftime("%H:%M")
      end

      it "参加したイベントの場所が表示されること" do
        expect(page).to have_content event_registration.event_listing.event.location
      end

      it "参加したイベントのタイトルが表示されること" do
        expect(page).to have_content event_registration.event_listing.title
      end

      it "参加したイベントの開催者の名前が表示されること" do
        expect(page).to have_content event_registration.event_listing.user.name
      end

      it "DMが表示されないこと" do
        expect(page).not_to have_content "DM"
      end
    end

    context "本人がログインし他のユーザー詳細ページにアクセスした場合" do
      before do
        visit user_path(second_user.id)
      end

      it "DMが表示されること" do
        expect(page).to have_content "DM"
      end

      it "DMをクリックしチャットページに遷移すること" do
        click_link "DM"
        expect(current_path).to eq chat_room_path(chat_room)
      end

      it "ユーザー編集リンクが表示されないこと" do
        expect(page).not_to have_content "ユーザー編集"
      end
    end
  end

  describe 'ユーザー編集ページの動作' do
    let!(:user) { FactoryBot.create(:user) }

    include_context 'logged in user'

    before do
      visit edit_user_registration_path(user)
    end

    it "ユーザー名が表示されること" do
      expect(page).to have_selector("input[type='text'][value='#{user.name}']")
    end

    it "ユーザーのEmailが表示されること" do
      expect(page).to have_selector("input[type='email'][value='#{user.email}']")
    end

    it "ファン歴が表示されること" do
      expect(page).to have_selector("input[type='text'][value='#{user.fan_years}']")
    end

    it "好きな選手が表示されること" do
      expect(page).to have_selector("input[type='text'][value='#{user.favorite_player}']")
    end

    it "自己紹介が表示されること" do
      expect(page).to have_content user.self_introduction
    end

    it "パスワードが表示されないこと" do
      expect(page).not_to have_content user.password
    end

    it "ユーザー編集できること" do
      fill_in 'user[name]', with: '編集太郎'
      fill_in 'user[email]', with: 'hensyu@example.com'
      fill_in 'user[fan_years]', with: '10'
      fill_in 'user[favorite_player]', with: '編集洋平'
      fill_in 'user[self_introduction]', with: '編集しました！'
      click_button '保存'
      expect(page).to have_content 'アカウント情報を変更しました。'
      visit user_path(user)
      expect(page).to have_content '編集太郎'
      expect(page).to have_content '10年'
      expect(page).to have_content '編集洋平'
      expect(page).to have_content '編集しました！'
    end

    it "パスワード編集できること" do
      fill_in 'user[password]', with: 'changepassword'
      fill_in 'user[password_confirmation]', with: 'changepassword'
      click_button '保存'
      expect(page).to have_content 'アカウント情報を変更しました。'
    end

    it "エラーメッセージが表示されること" do
      fill_in 'user[name]', with: ''
      fill_in 'user[email]', with: ''
      fill_in 'user[fan_years]', with: ''
      fill_in 'user[favorite_player]', with: ''
      fill_in 'user[self_introduction]', with: ''
      click_button '保存'
      expect(page).to have_content 'Eメールを入力してください'
      expect(page).to have_content '名前を入力してください'
      expect(page).not_to have_content 'ファン歴を入力してください'
      expect(page).not_to have_content '好きな女性を入力してください'
      expect(page).not_to have_content '自己紹介を入力してください'
    end
  end
end
