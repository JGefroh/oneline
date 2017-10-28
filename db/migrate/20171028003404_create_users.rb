class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :user_identifier
      t.string :mobile_phone_number
      t.boolean :mobile_phone_number_verified, default: false, null: false
    end
  end
end
