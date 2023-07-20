class CategoriesController < ApplicationController
    before_action :require_signin
  
    def index
        if current_user
          @categories = current_user.categories
        else
          @categories = []
        end
      end
    
      def show
        if current_user
          @category = current_user.categories.find(params[:id])
          @tasks = @category.tasks 
        else
          redirect_to new_session_url, alert: "Please Sign In first!"
        end
      end
  
    def new
      @category = current_user.categories.build
    end
  
    def create
      @category = current_user.categories.build(category_params)
      if @category.save
        redirect_to @category
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
      @category = current_user.categories.find(params[:id])
    end
  
    def update
      @category = current_user.categories.find(params[:id])
      if @category.update(category_params)
        flash[:notice] = "Category successfully updated!"
        redirect_to @category
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @category = current_user.categories.find(params[:id])
      @category.destroy
      redirect_to categories_url, status: :see_other
    end
  
    private
  
    def category_params
      params.require(:category).permit(:name, :description)
    end
  end
  