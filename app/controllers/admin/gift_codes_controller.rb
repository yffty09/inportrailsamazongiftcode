
class Admin::GiftCodesController < Admin::BaseController
  def index
    @gift_codes = GiftCode.includes(:user).order(created_at: :desc)
  end

  def create
    @user = User.find(params[:gift_code][:user_id])
    service = AmazonGiftCodeService.new
    @gift_code = @user.gift_codes.build(gift_code_params)
    
    if @gift_code.save
      result = service.create_gift_code(@gift_code)
      if result
        redirect_to admin_gift_codes_path, success: 'ギフトコードを作成しました'
      else
        @gift_code.destroy
        redirect_to admin_gift_codes_path, error: 'ギフトコードの作成に失敗しました'
      end
    else
      redirect_to admin_gift_codes_path, error: @gift_code.errors.full_messages.join(', ')
    end
  end
  
  private
  
  def gift_code_params
    params.require(:gift_code).permit(:amount, :currency_code, :user_id)
  end
end
