class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages, if_not_exists: true do |t|
      t.references :user, null: false, foreign_key: true
      t.string :role, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end
