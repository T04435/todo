require 'spec_helper'

describe "Editing todo lists" do
	let!(:todo_list){ TodoList.create(title: "Groceries", description: "Grocery list.")}

	def edit_todo_list(options={})
		options [:title] ||= "My todo list"
		options [:description] ||= "My todo list description"
		todo_list = options[:todo_list]

		visit "/todo_lists"
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
	end

	it "Update a todo list Successfully" do
		edit_todo_list(todo_list: todo_list, title: "New title", description: "New description")

		todo_list.reload

		expect(page).to have_content("Todo list was successfully update")
		expect(todo_list.title).to eq("New title")
		expect(todo_list.description).to eq("New description")

	end

	it "Test for empty title" do
		edit_todo_list(todo_list: todo_list, title: "")
		expect(page).to have_content("error")
	end

	it "Test for short title" do
		edit_todo_list(todo_list: todo_list, title: "Hi")
		expect(page).to have_content("error")
	end

	it "Test for empty description" do
		edit_todo_list(todo_list: todo_list, description: "")
		expect(page).to have_content("error")
	end

	it "Test for empty short description" do
		edit_todo_list(todo_list: todo_list, description: "todo")
		expect(page).to have_content("error")
	end


end
