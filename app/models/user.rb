class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :event_listings
  has_many :event_registrations
  has_many :chat_room_users
  has_many :chat_rooms, through: :chat_room_users
  mount_uploader :profile_image, ProfileImageUploader
  validates :name, presence: true
  validates :self_introduction, length: { maximum: 500 }

  def update_without_current_password(params, *options)
    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end
    result = update(params, *options)
    clean_up_passwords
    result
  end
end
