require 'rails_helper'

require 'spec_helper'

describe "Adding todo items" do
  let!(:todo_list) { TodoList.create(title: "Grocery list", description: "Groceries") }

  it "displays the title of the todo list" do
    visit_todo_list(todo_list)
    within("h1") do
      expect(page).to have_content(todo_list.title)
    end
  end  

  it "displays no items when a todo list is empty" do
    visit_todo_list(todo_list)
    expect(page.all("ul.todo_items li").size).to eq(0)
  end

  it "displays item content when a todo list has items" do
    todo_list.todo_items.create(content: "Milk")
    todo_list.todo_items.create(content: "Eggs")
    
    visit_todo_list(todo_list)
    
    expect(page.all("ul.todo_items li").size).to eq(2)
    
    within "ul.todo_items" do
      expect(page).to have_content("Milk")
      expect(page).to have_content("Eggs")
    end
  end

it "is successful with valid content" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: "Milk"
  click_button "Save"
  expect(page).to have_content("Added todo list item.")
  within("ul.todo_items") do
    expect(page).to have_content("Milk")
  end
end


it "displays an error with no content" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: ""
  click_button "Save"
  within("div.flash") do
    expect(page).to have_content("There was a problem adding the todo list item.")
  end
  expect(page).to have_content("Content can't be blank.")
end

it "displays an error with content less than 2 characters" do
  visit_todo_list(todo_list)
  click_link "New Todo Item"
  fill_in "Content", with: "1"
  click_button "Save"
  within("div.flash") do
    expect(page).to have_content("There was a problem adding the todo list item.")
  end
  expect(page).to have_content("Content is too short.")
end

end