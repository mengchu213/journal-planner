class CategoriesController < ApplicationController

    def index
        @categories = Category.all
    end

    def show
        @category = Category.find(params[:id])
    end

    def edit
        @category = Category.find(params[:id])
    end

    def update
        @category = Category.find(params[:id])
        @category.update(category_params)
        redirect_to @category
    end

    def new
    @category = Category.new
    end

    def create
    @category = Category.new(category_params)
     @category.save
     redirect_to @category
     end

     def destroy
        @category = Category.find(params[:id])
        @category.destroy
        redirect_to categories_url, status: :see_other
      end

      private

        def category_params
            params.require(:category).
            permit(:name, :description)
        end



end
