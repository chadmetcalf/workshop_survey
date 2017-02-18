class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys, id: :uuid do |t|
      t.belongs_to :user
      t.json :data
      t.datetime :finished_at

      t.timestamps
    end
  end
end
