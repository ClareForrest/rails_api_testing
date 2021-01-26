class TasksController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def index
    tasks = Task.all
    render json: { tasks: tasks }
  end

  def create
    task = Task.new(task_params)
    if task.save
      head :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :difficulty, :note)
  end
end