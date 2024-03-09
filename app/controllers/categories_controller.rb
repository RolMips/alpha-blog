class CategoriesController < ApplicationController

  def show
  end

  def index
  end

  def new
    @category = Category.new
  end

  def edit
  end

  def create
    @category = Category.new(category_params)
    if @category.save
        flash[:success] = "Category was succesfully created."
        redirect_to @category
    else
        render :new
    end
  end

  private

  def set_category
      @category = Category.find(params[:id])
  end

  def category_params
      params.require(:category).permit(:name)
  end

end
