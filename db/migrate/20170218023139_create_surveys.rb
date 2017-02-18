# frozen_string_literal: true
class CreateSurveys < ActiveRecord::Migration[5.0]
  def change
    create_table :surveys do |t|
      t.belongs_to :user
      t.datetime :finished_at

      t.timestamps
    end
  end
end
