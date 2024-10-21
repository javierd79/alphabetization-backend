class CreateCompanies < ActiveRecord::Migration[7.0]
  def change
    create_table :companies do |t|
      t.string :token
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
