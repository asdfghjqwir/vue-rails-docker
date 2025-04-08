module Api
  module V1
   class TodosController < ApplicationController
    before_action :authenticate_api_v1_user!
    before_action :set_todo, only: %i[ show update destroy ]


  # GET /todos
  def index
    @todos = current_api_v1_user.todos.order(created_at: :desc)
    render json: @todos
  end

  # GET /todos/1
  def show
    render json: @todo
  end

  # POST /todos
  def create
    @todo = current_api_v1_user.todos.new(todo_params)
    if @todo.save
      render json: @todo, status: :created
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      render json: @todo
    else
      render json: @todo.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo
      @todo = current_api_v1_user.todos.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def todo_params
      params.require(:todo).permit(:title, :completed)
    end
end
end
end
