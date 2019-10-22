class FeedBacksController < ApplicationController
  before_action :logged_in_user, except: %i(new create)
  before_action :load_feed_back, except: %i(new create index search_feed_back)
  before_action :load_feed_backs, only: %i(index search_feed_back)

  def index; end

  def new
    @feed_back = FeedBack.new
  end

  def create
    @feed_back = FeedBack.new feed_back_params
    if @feed_back.save
      flash[:success] = t "success"
      redirect_to feed_backs_path
    else
      render :new 
    end
  end

  def edit; end

  def update
    if @feed_back.update feed_back_params
      flash[:success] = t "success"
      redirect_to feed_backs_path
    else
      redirect_to feed_backs_path
    end
  end

  def destroy
    if @feed_back .destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to feed_backs_url
  end

  def search_feed_back
    respond_to do |format|
      format.html
      format.js
    end
  end

  private
  def feed_back_params
    params.require(:feed_back).permit FeedBack::FEEDBACK_PARAM
  end

  def load_feed_back
    @feed_back = FeedBack.find_by id: params[:id]
    return if @feed_back
    flash[:danger] = t "fail"
    redirect_to root_path
  end

  def load_feed_backs
    @feed_backs = FeedBack.where nil
    @feed_backs = @feed_backs.find_by_title_fb(params[:title]) if params[:title].present?
    @feed_backs = @feed_backs.page(params[:page]).per(Settings.paging_table).ordered_by_created
  end
end
