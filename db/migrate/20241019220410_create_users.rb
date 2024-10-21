class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :unique_user_identifier
      t.string :name
      t.string :email
      t.string :level
      t.string :role
      t.string :phone
      t.string :profession
      t.string :password_digest
      
      t.timestamps
    end
  end
end
