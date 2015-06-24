class TodoList < ActiveRecord::Base
	has_many :todo_items

	validates :title, presence: true, length: { minimum: 2 }
	validates :description, presence: true

	def has_completed_items? 
		todo_items.complete.size > 0
	end

	def has_incompleted_items?
		todo_items.incomplete.size > 0
	end
end
