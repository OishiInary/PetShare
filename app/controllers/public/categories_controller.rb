class Public::CategoriesController < ApplicationController
before_action :authenticate_user!
  def index
    @categories = Category.all
    # @category = Category.offset( rand(Category.count) ).limit(1)
  end  

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    @category_pets = Pet.where(category_id: @category.id).order(created_at: :desc).page(params[:page])
  end
end
