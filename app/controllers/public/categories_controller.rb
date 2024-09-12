class Public::CategoriesController < ApplicationController
  def index
    @categories = Category.all
    # @category = Category.offset( rand(Category.count) ).limit(1)
  end  

  def show
    @categories = Category.all
    @category = Category.find(params[:id])
  end
  
end