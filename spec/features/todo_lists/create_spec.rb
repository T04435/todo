require 'spec_helper'

describe "Creating todo lists" do
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "My todo list"
		fill_in "Description", with: "My todo list description"
		click_button "Create Todo list"

		expect(page).to have_content("My todo list")
	end

	it "display an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: ""
		fill_in "Description", with: "My todo list description"
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to have_content("My todo list description")
	end

	it "display an error when the todo list has a title less than 3 char" do
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: "Hi"
		fill_in "Description", with: "My todo list description"
		click_button "Create Todo list"


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to have_content("My todo list description")
	end
end