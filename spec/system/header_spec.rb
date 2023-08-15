require 'rails_helper'

RSpec.describe 'Header', type: :system do
  let(:user) { FactoryBot.create(:user) }
  context "ログインていない場合" do
    before do
      visit root_path
    end

    it "DRA-MATCHをクリックしたらトップページに戻る" do
      click_link 'DRA-MATCH'
      expect(current_path).to eq root_path
    end

    it "ログインをクリックしたらログイン画面に遷移する" do
      click_on 'ログイン'
      expect(current_path).to eq new_user_session_path
    end

    it "簡単登録をクリックしたらユーザー登録に遷移する" do
      click_on '簡単登録'
      expect(current_path).to eq new_user_registration_path
    end

    it "メニューボタンが表示されないこと" do
      expect(page).not_to have_content "メニュー"
    end

    it "募集登録ボタンが表示されないこと" do
      expect(page).not_to have_content "募集登録"
    end
  end

  context "ログインしている場合" do
    include_context 'logged in user'
    before do
      visit root_path
    end

    it "メニューボタンが表示されること" do
      click_on 'マイページ'
      expect(current_path).to eq user_path(user)
    end

    it "ログインをクリックしたらログイン画面に遷移する" do
      click_on '募集投稿'
      expect(current_path).to eq events_path
    end

    it "ログインボタンが表示されること" do
      expect(page).not_to have_content "ログイン"
    end

    it "募集登録ボタンが表示さないこと" do
      expect(page).not_to have_content "募集登録"
    end

    it "ログアウトできること" do
      click_on "ログアウト"
      expect(page).to have_content "ログアウトしました。"
      expect(page).not_to have_content "メニュー"
    end
  end
end
