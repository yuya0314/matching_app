require 'rails_helper'

RSpec.describe Event, type: :model do
  describe '正常系の機能' do
    it '正しく登録できること' do
      event = Event.new(
        date: Date.today + 15.days,
        match: '巨人',
        start_time: Time.current.change(hour: 18, min: 0),
        location: 'バンテリンドーム'
      )
      expect(event).to be_valid
      event.save
      expect(event.date).to eq(Date.today + 15.days)
      expect(event.match).to eq('巨人')
      expect(event.location).to eq('バンテリンドーム')
      expect(event.start_time.hour).to eq(18)
      expect(event.start_time.min).to eq(0)
    end
  end

  describe 'Eventバリデーション' do
    let(:event) { FactoryBot.create(:event) }

    it '開催日が必須であること' do
      event.date = nil
      expect(event).not_to be_valid
    end

    it '対戦チームが必須であること' do
      event.match = nil
      expect(event).not_to be_valid
    end

    it '開始時間が必須であること' do
      event.start_time = nil
      expect(event).not_to be_valid
    end

    it '球場が必須であること' do
      event.location = nil
      expect(event).not_to be_valid
    end
  end

  describe '.upcomingスコープ' do
    let!(:event_today) { FactoryBot.create(:event) }
    let!(:event_future) { FactoryBot.create(:event, date: Date.today + 5.days) }
    let!(:event_past) { FactoryBot.create(:event, date: Date.today - 5.days) }
  
    it 'returns events that are today or in the future' do
      expect(Event.upcoming).to include(event_today, event_future)
      expect(Event.upcoming).not_to include(event_past)
    end
  end
end  
