class BillsController < ApplicationController
  before_action :logged_in_user, :load_bill, except: %i(new create index)
  before_action :admin_user, except: %i(show index)
  before_action :load_room, :load_service, except: %i(index)

  def index
    @bills = Bill.page(params[:page]).per(Settings.paging_table).ordered_by_created
  end

  def new
    @bill = Bill.new
  end

  def create
    @bill = Bill.new bill_params
    if @bill.save
      @room.update payment: @bill.status
      @bill.service_ids = params[:bill][:bill_services]
      flash[:success] = t "success"
      redirect_to room_bill_path(@room.id, @bill)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @bill.update bill_params
      @room.update payment: @bill.status
      @bill.service_ids = params[:bill][:bill_services]
      flash[:success] = t "success"
      redirect_to room_bill_path(@room.id, @bill)
    else
      flash[:danger] = t "error"
      redirect_to bill_path(@bill.room_id)
    end
  end
  
  def destroy
    if @bill.destroy
      @room.update payment: Settings.status_unpayment
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to room_bills_path
  end
  
  def show; end

  private
  def bill_params
    params.require(:bill).permit Bill::BILL_PARAMS
  end

  def load_room
    @room = Room.find_by id: params[:room_id]
    return if @room.present?
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def load_bill
    @bill = Bill.find_by id: params[:id]
    return if @bill.presence
    flash[:danger] = t "error"
    redirect_to root_path
  end

  def load_service
    @services = Service.page(params[:page]).per Settings.paging_table
    return if @services.present?
    flash[:danger] = t "error"
    redirect_to root_path
  end
end
