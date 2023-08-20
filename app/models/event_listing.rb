class EventListing < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :event_registrations, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence: true, length: { maximum: 20 }
  validates :deadline, presence: true
  validate :deadline_not_past
  validate :deadline_not_later_event_date
  validates :message, presence: true, length: { maximum: 300 }
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :has_ticket, exclusion: { in: [nil], message: "を入力して下さい" }

  def deadline_not_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "過去の日付は指定できません")
    end
  end

  def deadline_not_later_event_date
    if deadline.present? && deadline > event.date
      errors.add(:deadline, "観戦日より後の日付は指定できません")
    end
  end
end
