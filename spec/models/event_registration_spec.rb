require 'rails_helper'

RSpec.describe EventRegistration, type: :model do
  describe '正常系の機能' do
    let!(:user) { FactoryBot.create(:user) }
    let(:event) { FactoryBot.create(:event) }
    let(:event_listing) { FactoryBot.create(:event_listing, event: event) }

    context '投稿する' do
      it '正しく登録できること' do
        event_registration = EventRegistration.new(
          event_listing: event_listing,
          user: user,
          comment: '早めに球場入りしたいです！'
        )
        expect(event_registration).to be_valid
        event_registration.save
        expect(event_registration.comment).to eq('早めに球場入りしたいです！')
        expect(event_registration.user.name).to eq('山田太郎')
        expect(event_registration.event_listing.title).to eq('男女問わず参加してください！')
      end
    end
  end

  describe 'EventRegistrationバリデーション' do
    let(:event_registration) { FactoryBot.create(:event_registration) }

    it '参加コメントが必須であること' do
      event_registration.comment = nil
      expect(event_registration).not_to be_valid
    end

    it '参加コメントの文字数が50文字以下であること' do
      event_registration.comment = 'a' * 50
      expect(event_registration).to be_valid
    end

    it '参加コメントの文字数が51文字以上であれば保存できないこと' do
      event_registration.comment = 'a' * 51
      expect(event_registration).not_to be_valid
    end
  end
end
