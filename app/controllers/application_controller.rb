class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def sign_in_required
    unless user_signed_in?
      flash[:danger] = "ログインが必要です。"
      redirect_to root_path
    else
      return false
    end
  end

  def sign_in_already
    redirect_to user_root_path if user_signed_in?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |user,pass|
      user == ENV["BASIC_NAME"] && pass == ENV["BASIC_PASSWORD"]
    end
  end

end
