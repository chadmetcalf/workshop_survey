class AddTypeToSurvey < ActiveRecord::Migration[5.0]
  def change
    add_column :surveys, :type, :string, null: true

    change_column_null(:surveys,
                       :type,
                       false,
                       Survey.update_all(type: 'WorkshopRegistration'))
  end
end
