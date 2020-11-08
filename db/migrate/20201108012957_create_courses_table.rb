class CreateCoursesTable < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :schedule
      t.string :assignments
      t.string :notes
      t.integer :user_id
    end
  end
end
