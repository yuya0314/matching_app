require 'rails_helper'

RSpec.describe EventListing, type: :model do
  describe '正常系の機能' do
    let(:event) { FactoryBot.create(:event) }
    let(:user) { FactoryBot.create(:user) }

    context '投稿する' do
      it '正しく登録できること' do
        event_listing = EventListing.new(
          event: event,
          user: user,
          title: '男女問わず参加してください！',
          message: 'ライトスタンドで一緒に熱く応援しましょう！応援歌一緒に歌える方がいいです！' ,
          deadline: Date.today + 7.days ,
          capacity: 3 ,
          has_ticket: true 
        )
        expect(event_listing).to be_valid
        event_listing.save
        expect(event_listing.title).to eq( '男女問わず参加してください！' )
        expect(event_listing.message).to eq( 'ライトスタンドで一緒に熱く応援しましょう！応援歌一緒に歌える方がいいです！' )
        expect(event_listing.deadline).to eq( Date.today + 7.days )
        expect(event_listing.capacity).to eq(3)
        expect(event_listing.has_ticket).to eq( true )
      end
    end
  end

  describe 'EventListingバリデーション' do
    let(:event_listing) { FactoryBot.create(:event_listing) }

    context '必須入力項目の確認' do
      it 'タイトルが必須であること' do
        event_listing.title = nil
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:title]).to include(I18n.t('errors.messages.blank'))
      end

      it 'deadlineが必須であること' do
        event_listing.deadline = nil
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:deadline]).to include(I18n.t('errors.messages.blank'))
      end
      
      it 'messageが必須であること' do
        event_listing.message = nil
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:message]).to include(I18n.t('errors.messages.blank'))
      end

      it 'capacityが必須であること' do
        event_listing.capacity = nil
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:capacity]).to include(I18n.t('errors.messages.blank'))
      end

      it 'has_ticketが必須であること' do
        event_listing.has_ticket = nil
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:has_ticket]).to include("を入力して下さい")
      end
    end

    context '文字数の確認' do
      it 'タイトルの文字数が20文字以下であること' do
        event_listing.title = 'a' * 20
        expect(event_listing).to be_valid
      end
    
      it 'タイトルの文字数が21文字以上であれば保存できないこと' do
        event_listing.title = 'a' * 21
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:title]).to include('は20文字以内で入力してください')
      end

      it 'メッセージの文字数が300文字以下であること' do
        event_listing.message = 'a' * 300
        expect(event_listing).to be_valid
      end
    
      it 'メッセージの文字数が300文字以上の時エラーが発生すること' do
        event_listing.message = 'a' * 301
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:message]).to include('は300文字以内で入力してください')
      end
    end

    context '数値性の確認' do
      it 'capacityが0文字より大きいここと' do
        event_listing.capacity = 1
        expect(event_listing).to be_valid
      end

      it 'capacityが0文字以下ならエラーが発生すること'  do
        event_listing.capacity = -1
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:capacity]).to include('は0より大きい値にしてください')
      end
    end
  end

  describe 'EventListingバリデーションメソッド' do
    let(:event) { FactoryBot.create(:event) }
    let(:event_listing) { FactoryBot.create(:event_listing) }
    context 'deadline_not_past' do
      it '保存できないこと' do
        event_listing.deadline = Date.yesterday
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:deadline]).to include("過去の日付は指定できません")
      end
    
      it '保存できること' do
        event_listing.deadline = Date.tomorrow
        expect(event_listing).to be_valid
      end
    end

    context 'deadline_not_later_event_date' do
      it '保存できないこと' do
        event_listing.deadline = event.date + 1.day
        expect(event_listing).not_to be_valid
        expect(event_listing.errors[:deadline]).to include("観戦日より後の日付は指定できません")
      end
    
      it '保存できること' do
        event_listing.deadline = event.date - 1.day
        expect(event_listing).to be_valid
      end
    end
  end
end
