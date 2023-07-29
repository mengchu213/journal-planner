class CategoriesController < ApplicationController
  before_action :require_signin, except: [:show]
  before_action :set_category, only: [:edit, :update, :destroy]

  # The index action fetches all categories of the current user if there is one.
  # If there is no current user, an empty array is assigned to @categories.
  def index
    if current_user
      @categories = current_user.categories
    else
      @categories = []
    end
  end

  # The show action sets the category and tasks for the current user.
  # If there is no current user, it redirects to the sign in page.
  def show
    if current_user
      set_category
      @tasks = @category.tasks 
    else
      redirect_to new_session_url, alert: "Please Sign In first!"
    end
  end

  # The new action initializes a new category associated with the current user.
  def new
    @category = current_user.categories.build
  end

  # The create action creates a new category with the submitted parameters.
  # If the category is saved successfully, it redirects to the show page for that category.
  def create
    @category = current_user.categories.build(category_params)
    if @category.save
      redirect_to @category
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  # The update action updates the category with the submitted parameters.
  # If the category is updated successfully, it redirects to the show page for that category.
  def update
    if @category.update(category_params)
      flash[:notice] = "Category successfully updated!"
      redirect_to @category
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # The destroy action deletes the category and redirects to the index page with a see_other status.
  def destroy
    @category.destroy
    redirect_to categories_url, status: :see_other
  end

  private

  # This method specifies the permitted parameters for a category.
  def category_params
    params.require(:category).permit(:name, :description)
  end

  # This method fetches the category based on the current user and the id parameter from the URL.
  def set_category
    @category = current_user.categories.find(params[:id])
  end
end
