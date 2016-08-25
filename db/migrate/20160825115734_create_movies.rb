class CreateMovies < ActiveRecord::Migration[5.0]
  def change
    enable_extension 'hstore' unless extension_enabled?('hstore')
    create_table :movies do |t|
      t.string :title
      t.hstore :info, default: {}
      t.float :rank
      t.string :douban_id, null: false, unique: true
      t.integer :status, default: 0
      t.timestamps
    end

    add_index :movies, :douban_id, unique: true
  end
end
