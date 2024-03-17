# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :set_category, only: %i[show edit update]
  before_action :require_admin, except: %i[show index]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @category.articles.paginate(page: params[:page], per_page: 2)
  end

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

  def update
    if @category.update(category_params)
      flash[:success] = 'Category name was succesfully updated.'
      redirect_to @category
    else
      render :edit
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
