class Users::SessionsController < Devise::SessionsController
    def create
      super
      cookies.signed['user.id'] = current_user.id if user_signed_in?
    end
  
    def destroy
      cookies.delete('user.id')
      super
    end
  end
  