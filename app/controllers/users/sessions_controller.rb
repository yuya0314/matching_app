class Users::SessionsController < Devise::SessionsController
  def guest_sign_in
    user = User.guest
    sign_in user
    flash[:success] = 'ゲストユーザーとしてログインしました。'
    redirect_to root_path
  end
end
