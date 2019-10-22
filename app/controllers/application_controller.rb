class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_locale
  
  private
    def set_locale
      locale = params[:locale].to_s.strip.to_sym
      I18n.locale = I18n.available_locales.include?(locale) ?
      locale : I18n.default_locale
    end

    def redirect_back_or(default)
      redirect_to session[:forwarding_url] || default
      session.delete :forwarding_url
    end

    def logged_in_user
      return if logged_in?
      store_location
      flash[:danger] = t "error"
      redirect_to login_url
    end

    def store_location
      session[:forwarding_url] = request.original_url if request.get?
    end

    def admin_user
      return if current_user.manager?
      flash[:danger] = t "error"
      redirect_to root_url
    end
end
