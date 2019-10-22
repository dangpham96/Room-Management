class ServicesController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_services, except: %i(new create index)
  before_action :admin_user, except: %i(show)

  def index
    @services = Service.page(params[:page]).per(Settings.paging_table).ordered_by_number
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new services_params
    if @service.save
      flash[:success] = t "success"
      redirect_to @service
    else
      render :new
    end
  end

  def show; end

  def update
    if @service.update services_params
      flash[:success] = t "success"
      redirect_to services_path
    else
      render :edit
    end
  end

  def destroy
    if @service.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to services_url
  end

  private
  def services_params
    params.require(:service).permit Service::SERVICE_PARAMS
  end

  def load_services
    @service = Service.find_by id: params[:id]
    return if @service
    flash[:danger] = t "fail"
    redirect_to root_path
  end
end
