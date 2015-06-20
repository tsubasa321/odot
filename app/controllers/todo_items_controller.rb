class TodoItemsController < ApplicationController
  def index
  	@todo_list = TodoList.find(params[:todo_list_id])
  end

  def new
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new # This way, a new todo item is added to the todo list
  end

  def create
  	@todo_list = TodoList.find(params[:todo_list_id])
  	@todo_item = @todo_list.todo_items.new(params_todo_item)

  	if @todo_item.save
  		flash[:success] = "Successfully added new todo item."
  		redirect_to todo_list_todo_items_path
  	else
  		flash[:error] = "Unable to add this new todo item."
  		render action: :new
  	end
  end

  private
  def params_todo_item
  	params[:todo_item].permit(:content)
  end

end
