require 'spec_helper'
require 'rails_helper'

describe "Editing todo lists" do
  let!(:todo_list) { TodoList.create(title: "Groceries") }

  def update_todo_list(options={})
    options[:title] ||= "My todo list"
    todo_list = options[:todo_list]

    visit "/todo_lists"
    within "#todo_list_#{todo_list.id}" do
      click_link "Edit"
    end

    fill_in "Title", with: options[:title]
    click_button "Update Todo list"
  end

  it "updates a todo list successfully with correct information" do
    update_todo_list todo_list: todo_list, 
                     title: "New title", 

    todo_list.reload

    expect(page).to have_content("Todo list was successfully updated")
    expect(todo_list.title).to eq("New title")
  end

  it "displays an error with no title" do
    update_todo_list todo_list: todo_list, title: ""
    title = todo_list.title
    todo_list.reload
    expect(todo_list.title).to eq(title)
    expect(page).to have_content("error")
  end

  it "displays an error with too short a title" do
    update_todo_list todo_list: todo_list, title: "hi"
    expect(page).to have_content("error")
  end


end