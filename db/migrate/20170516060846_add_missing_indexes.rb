class AddMissingIndexes < ActiveRecord::Migration[5.0]
	def change
		add_index :surveys, :user_id
		add_index :surveys, [:id, :type]
	end
end
