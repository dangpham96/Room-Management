class RoomsController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_room, except: %i(new create index search_room)
  before_action :admin_user, except: %i(show index search_room)
  before_action :load_rooms, only: %i(index search_room)
  
  def index; end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new room_params
    if @room.save
      flash[:success] = t "success"
      redirect_to @room
    else
      render :new 
    end
  end

  def edit; end

  def update
    if @room.update room_params
      flash[:success] = t "success"
      redirect_to @room
    else
      render :edit
    end
  end

  def show; end

  def destroy
    if @room.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to rooms_url
  end

  def search_room
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def room_params
    params.require(:room).permit Room::ROOM_PARAMS
  end

  def load_room
    @room = Room.find_by id: params[:id]
    return if @room
    flash[:danger] = t "fail"
    redirect_to root_path
  end

  def load_rooms
    @rooms = Room.where nil
    @rooms = @rooms.find_by_status_room(params[:status]) if params[:status].present?
    @rooms = @rooms.page(params[:page]).per(Settings.paging_table_room).ordered_by_id
  end
end
