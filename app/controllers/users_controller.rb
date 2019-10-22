class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_user, except: %i(new create index search)
  before_action :admin_user, except: %i(show)
  before_action :load_users, only: %i(index search)

  def index; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    load_room_user @user if @user.room_id.present?
    if @user.save
      @room.update status: @user.status if @user.room_id.present?
      flash[:success] = t "success"
      redirect_to @user
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update user_params
      load_room_user @user
      @room.update status: @user.status
      flash[:success] = t "success"
      redirect_to users_path
    else
      render :edit
    end
  end 

  def show; end

  def destroy
    if @user.destroy
      load_room_user @user
      @room.update status: Settings.status_unactive
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to users_url
  end

  def search_user
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def load_user
    @user = User.find_by_id params[:id]
    return if @user
    flash[:danger] = t "fail"
    redirect_to root_path
  end

  def load_room_user user
    @room = Room.find_by id: user.room_id
    return if @room
    flash[:danger] = t "fail"
  end

  def load_users
    @users = User.where nil
    @users = @users.find_by_name_user(params[:name]) if params[:name].present?
    @users = @users.page(params[:page]).per Settings.paging_table
  end
end
