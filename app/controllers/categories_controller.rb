class CategoriesController < ApplicationController
  before_action :logged_in_user
  before_action :load_category, except: %i(new create index)
  before_action :admin_user, except: %i(show)

  def index
    @categorys = Category.page(params[:page]).per(Settings.paging_table).ordered_by_number
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "success"
      redirect_to @category
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] =  t "success"
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "success"
    else
      flash[:danger] = t "fail"
    end
    redirect_to categories_url
  end

  private
  def category_params
    params.require(:category).permit Category::CATEGORY_PARAMS
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t "not_exist"
    redirect_to root_path
  end
end
