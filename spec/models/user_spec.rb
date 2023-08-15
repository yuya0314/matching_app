require 'rails_helper'

RSpec.describe User, type: :model do
  describe '正常系の機能' do
    context '投稿する' do
      it '正しく登録できること' do
        user = User.new(
          name: '山田太郎',
          email: 'taroyamada@example.com',
          password: 'password',
          self_introduction: 'よろしくお願いします！',
          fan_years: 5,
          favorite_player: '大島洋平'
        )
        expect(user).to be_valid
        user.save
        expect(user.name).to eq('山田太郎')
        expect(user.email).to eq('taroyamada@example.com')
        expect(user.password).to eq('password')
        expect(user.self_introduction).to eq('よろしくお願いします！')
        expect(user.fan_years).to eq(5)
        expect(user.favorite_player).to eq('大島洋平')
      end
    end
  end

  describe 'Userバリデーション' do
    let(:user) { FactoryBot.create(:user) }
    context '文字数の確認' do
      it '自己紹介の文字数が500文字以下であること' do
        user.self_introduction = 'a' * 500
        expect(user).to be_valid
      end

      it '自己紹介の文字数が21文字以上であれば保存できないこと' do
        user.self_introduction = 'a' * 501
        expect(user).not_to be_valid
        expect(user.errors[:self_introduction]).to include('は500文字以内で入力してください')
      end
    end
  end
end
