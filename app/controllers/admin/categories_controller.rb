class Admin::CategoriesController < ApplicationController
before_action :authenticate_admin!
    
    def index
        @categories = Category.all
    end
    
    def show
        @category = Category.find(params[:id])
    end  
    
    def new
        @category = Category.new
    end
    
    def create
        @category = Category.new(category_params)
        @category.save
        redirect_to admin_categories_path
    end 
    
    def edit
        @category = Category.find(params[:id])
    end
    
    def update
        @category = Category.find(params[:id])
        if @category.update(category_params)
          flash[:notice] = "更新に成功しました"
          redirect_to admin_categories_path
        else
          flash[:notice] = "更新に失敗しました"
          @category = Category.find(params[:id])
          redirect_back(fallback_location: admin_root_path)
        end
    end 
    
    def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_back(fallback_location: admin_root_path)
    end  

   private
   
   def category_params
    params.require(:category).permit(:name,:introduction,:difficulty,:image)
   end

end
