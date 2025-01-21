
class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all.includes(:gift_codes)
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('users-table-body', partial: 'admin/gift_codes/user_row', locals: { user: @user }),
            turbo_stream.update('new_user_form', partial: 'admin/gift_codes/user_form', locals: { user: User.new })
          ]
        end
        format.html { redirect_to admin_users_path, success: 'ユーザーを作成しました' }
      end
    else
      flash.now[:error] = 'ユーザー作成に失敗しました'
      render :index, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password, :password_confirmation)
  end
end
