json.array!(@todo_lists) do |todo_list|
  json.url todo_list_url(todo_list, format: :json)
end
