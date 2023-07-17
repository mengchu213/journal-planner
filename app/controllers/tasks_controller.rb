class TasksController < ApplicationController
        before_action :set_category
        before_action :set_task, only: [:edit, :update, :destroy]
      
        def index
          @tasks = @category.tasks
        end
      
        def new
          @task = @category.tasks.new
        end
      
        def create
          @task = @category.tasks.new(task_params)
          if @task.save
            redirect_to category_tasks_url(@category), notice: "Task Created!"
          else
            render :new, status: :unprocessable_entity
          end
        end
      
        def edit
        end
      
        def update
          if @task.update(task_params)
            flash[:notice] = "Task successfully updated!"
            redirect_to category_tasks_url(@category)
          else
            render :edit, status: :unprocessable_entity
          end
        end
      
        def destroy
          @task.destroy
          redirect_to category_tasks_url(@category), status: :see_other
        end
      
        private
      
        def task_params
          params.require(:task).permit(:name, :description)
        end
      
        def set_category
          @category = Category.find(params[:category_id])
        end
      
        def set_task
          @task = @category.tasks.find(params[:id])
        end
end
      