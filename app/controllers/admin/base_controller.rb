class Admin::BaseController < ApplicationController
  before_action :require_login
  before_action :check_admin
  layout 'admin'

  private

  def not_authenticated
    flash[:warning] = 'ログインしてください'
    redirect_to admin_login_path
  end

  def check_admin
    unless current_administrator
      flash[:warning] = '管理者権限が必要です'
      redirect_to admin_login_path
    end
  end

  def current_administrator
    @current_administrator ||= Administrator.find_by(id: session[:administrator_id]) if session[:administrator_id]
  end
end
