class CreateSubjects < ActiveRecord::Migration[7.0]
  def change
    create_table :subjects do |t|
      t.string :name
      t.date :beginning
      t.date :ending
      t.integer :max_students
      t.string :days, array: true, default: []
      t.integer :students_subscribed, array: true, default: []
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
