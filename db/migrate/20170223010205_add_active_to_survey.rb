class AddActiveToSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :active, :boolean, default: true
  end
end
