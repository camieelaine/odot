class TodoItemsController < ApplicationController
  def index
  	#find todo_list - get todo_list_id from routes
  	@todo_list = TodoList.find(params[:todo_list_id])
  end
end
