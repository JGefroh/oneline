class CreateListItems < ActiveRecord::Migration[5.1]
  def change
    create_table :list_items do |t|
      t.text :label
      t.date :date
      t.time :time
      t.datetime :notified_at
      t.text :original_text
      t.string :user_identifier
      t.timestamps
    end
  end
end
