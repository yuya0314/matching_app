class EventListing < ApplicationRecord
  belongs_to :event
  belongs_to :user
  has_many :event_registrations
  validates :title,presence: true, length: { maximum: 30 }
  validates :deadline,presence: true
  validates :message,presence: true, length: { maximum: 300}
  validates :capacity,presence: true,numericality: {greater_than: 0}
  validates :has_ticket,exclusion: {in:[nil]}
  validate :deadline_not_past

  def deadline_not_past
    if deadline.present? && deadline < Date.today
      errors.add(:deadline, "過去の日付は指定できません")
    end
  end
end
