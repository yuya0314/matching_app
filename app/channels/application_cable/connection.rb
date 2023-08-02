module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      current_user = find_verified_user
      reject_unauthorized_connection unless current_user
    end

    private

    def find_verified_user
      User.find_by(id: cookies.signed['user.id'])
    end
  end
end
