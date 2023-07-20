class TasksController < ApplicationController
  before_action :require_signin
  before_action :set_category
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_category_owner, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @tasks = @category.tasks
    else
      @tasks = []
    end
  end

  def today
    @tasks = current_user.tasks.where("deadline::date = ?", Date.today)
  end
  

  def new
    @task = @category.tasks.new
  end

  def create
    @task = @category.tasks.new(task_params)
    @task.completed = false unless @task.completed
    if @task.save
      redirect_to category_url(@category), notice: "Task Created!"
    else
      render :new, status: :unprocessable_entity
    end
  end
  

  def edit
  end

  def update
    if update_task
      flash.now[:notice] = "Task successfully updated!"
      handle_successful_update
    else
      handle_failed_update
    end
  end
  

  def destroy
    @task.destroy
    redirect_to category_url(@category), status: :see_other
  end

  def show
    if current_user
      @task = @category.tasks.find(params[:id])
    else
      redirect_to new_session_url, alert: "Please Sign In first!"
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :description, :deadline, :completed)
  end

  def set_category
    @category = Category.find(params[:category_id])
  end

  def set_task
    @task = @category.tasks.find(params[:id])
  end

  def require_category_owner
    redirect_to categories_url, status: :see_other unless current_user?(@category.user)
  end

  def update_task
    @task.update(task_params)
  end

  def handle_successful_update
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update('flash', partial: 'layouts/flash', locals: { flash: flash }) +
                            turbo_stream.replace('tasks_frame', partial: 'tasks/tasks', locals: { tasks: @category.tasks, category: @category })
      end
      format.html { redirect_to category_url(@category) }
    end
  end
  

  def handle_failed_update
    render :edit, status: :unprocessable_entity
  end
end
