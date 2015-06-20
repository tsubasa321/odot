class TodoList < ActiveRecord::Base
	has_many :todo_items

	validates :title, presence: true, length: { minimum: 2 }
	validates :description, presence: true
end
