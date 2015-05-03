require 'spec_helper'

describe "Creating todo lists" do
	def create_todo_list(options={})
		options [:title] ||= "My todo list"
		options [:description] ||= "My todo list description"

		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"


	end

	it "redirects to the todo list index page on success" do
		create_todo_list()

		expect(page).to have_content("My todo list")
	end

	it "display an error when the todo list has no title" do
		expect(TodoList.count).to eq(0)

		create_todo_list(title:"")


		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list description")
	end

	it "display an error when the todo list has a title less than 3 char" do
		expect(TodoList.count).to eq(0)

		create_todo_list(title:"Hi")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("My todo list description")
	end

	it "display an error when the todo list has no description" do
		expect(TodoList.count).to eq(0)

		create_todo_list(description:"")

		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("new list")
	end

	it "display an error when the todo list has description  has no less than 5 char" do
		expect(TodoList.count).to eq(0)

		create_todo_list(description:"todo")
		
		expect(page).to have_content("error")
		expect(TodoList.count).to eq(0)

		visit "/todo_lists"
		expect(page).to_not have_content("new list")
	end

end
