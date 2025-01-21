class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_login, only: %i[new create]
  skip_before_action :check_admin, only: %i[new create]

  def new; end

  def create
    if @administrator = Administrator.authenticate(params[:email], params[:password])
      session[:administrator_id] = @administrator.id
      redirect_to admin_root_path, success: '管理者としてログインしました'
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが正しくありません"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout
    redirect_to admin_login_path, success: 'ログアウトしました'
  end
end
