class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:edit, :update, :destroy]

  def index
    redirect_to board_list_path(@list.board_id, @list)
  end

  def new
    @task = @list.tasks.new
  end

  def create
    Task.create_task(task_params, @list.id)
    redirect_to @list
  end

  def edit
  end

  def update
    Task.update_task(@task.id, task_params)
    redirect_to @list
  end

  def destroy
    Task.delete_task(@task.id)
    redirect_to @list
  end

  private

    def set_list
      @list = List.single_list(params[:list_id])
    end
  
    def set_task
      @task = Task.single_task(params[:id])
    end

    def task_params
      params.require(:task).permit(:name, :finished, :priority_number)
    end
end
