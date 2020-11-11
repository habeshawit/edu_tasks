class ChangeAssignmentColumnType < ActiveRecord::Migration
  def change
    change_column :courses, :assignments, :text
    change_column :courses, :notes, :text
  end
end
