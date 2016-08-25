class AddAttrsToMovies < ActiveRecord::Migration[5.0]
  def change
    add_column :movies, :genre, :string, array: true
    add_column :movies, :starring, :string, array: true
    add_column :movies, :director, :string, array: true
    add_column :movies, :release_date, :date
    add_column :movies, :runtime, :integer
    add_column :movies, :sum_of_rank, :integer

    add_index :movies, :genre, using: :gin
    add_index :movies, :director, using: :gin
    add_index :movies, :starring, using: :gin
  end
end
