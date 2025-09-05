class TodosController < ApplicationController
  before_action :set_todo, only: %i[ destroy edit show toggle_complete update ]

  # POST /todos
  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # DELETE /todos/1
  def destroy
    @todo.destroy
    redirect_to todos_path, notice: "Todo was successfully deleted."
  end

  # GET /todos/1/edit
  def edit
  end

  # GET /todos
  def index
    @pending_todos = Todo.where(completed: false).order(created_at: :desc)
    @completed_todos = Todo.where(completed: true).order(created_at: :desc)
    @completed_count = @completed_todos.size
    @total_count = @pending_todos.size + @completed_todos.size
  end

  # GET /todos/new
  def new
    @todo = Todo.new
  end

  # GET /todos/1
  def show
  end

  # PATCH /todos/1/toggle_complete
  def toggle_complete
    if @todo.update(completed: !@todo.completed)
      redirect_to todos_path
    else
      render :show, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todos/1
  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.expect(todo: [ :completed,  :description, :title ])
  end
end
