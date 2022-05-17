class CreateGuests < ActiveRecord::Migration[7.0]
  def change
    create_table :guests do |t|
      t.string :email, unique: true
      t.string :first_name
      t.string :last_name
      t.text :phone_numbers
      t.timestamps
    end
  end
end
