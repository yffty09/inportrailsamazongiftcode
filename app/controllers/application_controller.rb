class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :require_login

  add_flash_types :primary, :success, :warning, :danger

  private
  def not_authenticated
    redirect_to admin_login_path, alert: "ログインしてください"
  end
end