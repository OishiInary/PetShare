class ApplicationController < ActionController::Base
  #Deviseコントローラー使うときにその前にparam許可して情報を受け取る処理
  before_action :configure_permitted_parameters, if: :devise_controller?
  #以下二つは無効な遷移、無効なデータ取得が行われた際のレスキュー
  rescue_from ActionController::RoutingError, with: :handle_routing_error
  rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
  @year = Time.current.year
  
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_root_path
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

    # ルーティングエラーの処理
  def routing_error
    flash[:alert] = "指定されたページが見つかりません。トップページにリダイレクトされます。"
    redirect_to root_path
  end

  private

  # RoutingErrorが発生した場合にトップページへリダイレクト
  def handle_routing_error
    flash[:alert] = "無効なページが指定されました。トップページにリダイレクトされました。"
    redirect_to root_path
  end

  # RecordNotFoundが発生した場合にトップページへリダイレクト
  def handle_not_found
    flash[:alert] = "該当するページが見つかりませんでした。トップページにリダイレクトされました。"
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email, :post_code, :address, :phone, :hope, :gender, :birthday, :introduction])
  end
  
end
