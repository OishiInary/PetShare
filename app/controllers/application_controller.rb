class ApplicationController < ActionController::Base
  #Deviseコントローラー使うときにその前にparam許可して情報を受け取る処理
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when User
      root_path
    else
      root_path
    end
  end
    # ログアウト後のリダイレクト先
  def after_sign_out_path_for(resource_or_scope)
    if resource_or_scope == :admin
      new_admin_session_path
    else
      new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :post_code, :address, :phone, :type, :gender, :birthday, :introduction])
  end
  
end
