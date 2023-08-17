class RegistrationsController < Devise::RegistrationsController
  protected

  before_action :ensure_normal_user, only: :update

  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to root_path, alert: 'ゲストユーザーは更新できません。'
    end
  end
end
