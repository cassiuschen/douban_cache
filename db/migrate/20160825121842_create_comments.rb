class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :rank, default: 0
      t.integer :valueable, default: 0
      t.text :content, null: false
      t.belongs_to :movie, foreign_key: true

      t.timestamps
    end
  end
end
