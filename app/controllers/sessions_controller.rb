class SessionsController < ApplicationController

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password]) 
      log_in user
      flash[:success] = t("login_page.login_success")
      if current_user.manager?
        redirect_to rooms_path
      else
        redirect_back_or user
      end
    else
      flash.now[:danger] = t "login_page.login_error"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
