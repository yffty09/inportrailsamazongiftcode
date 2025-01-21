
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.includes(:gift_codes)
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, success: 'ユーザーを作成しました'
    else
      @users = User.all.includes(:gift_codes)
      flash.now[:error] = 'ユーザー作成に失敗しました'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
