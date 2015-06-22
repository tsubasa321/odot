class TodoItemsController < ApplicationController
  before_action :find_todo_list

  def index
  end

  def new
  	@todo_item = @todo_list.todo_items.new # This way, a new todo item is added to the todo list
  end

  def create
  	@todo_item = @todo_list.todo_items.new(params_todo_item)

  	if @todo_item.save
  		flash[:success] = "Successfully added new todo item."
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = "Unable to add this new todo item."
  		render action: :new
  	end
  end

  def edit
    @todo_item = @todo_list.todo_items.find(params[:id])
  end

  def update
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.update_attributes(params_todo_item)
      flash[:success] = "Successfully Edited new todo item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "Unable to save this new todo item."
      render action: :edit
    end
  end

  def destroy
    @todo_item = @todo_list.todo_items.find(params[:id])

    if @todo_item.destroy
      flash[:success] = "Successfully deleted Todo Item."
      redirect_to todo_list_todo_items_path
    else
      flash[:error] = "Unable to delete this new todo item."
      render action: :index
    end
  end

  private

  def find_todo_list
    @todo_list = TodoList.find(params[:todo_list_id])
  end
  def params_todo_item
  	params[:todo_item].permit(:content)
  end

end
