
class Admin::GiftCodesController < Admin::BaseController
  def index
    @gift_codes = GiftCode.includes(:user).order(created_at: :desc)
  end

  def create
    @gift_code = GiftCode.new(gift_code_params)
    @gift_code.created_by = current_administrator.id
    @gift_code.updated_by = current_administrator.id
    @gift_code.status = :created
    @gift_code.unique_url = SecureRandom.hex(16)
    @gift_code.expires_at = 30.days.from_now
    
    if @gift_code.save
      redirect_to admin_gift_codes_path, success: 'ギフトコードを作成しました'
    else
      redirect_to admin_gift_codes_path, error: @gift_code.errors.full_messages.join(', ')
    end
  end
  
  private
  
  def gift_code_params
    params.require(:gift_code).permit(:user_id, :amount, :currency_code)
  end
end
