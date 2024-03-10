# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  before_action :require_admin, except: %i[show index]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show; end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = 'Category was succesfully created.'
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

  def require_admin
    return if logged_in? && current_user.admin?

    flash[:danger] = 'Only administrators can perform that action'
    redirect_to categories_path
  end
end
