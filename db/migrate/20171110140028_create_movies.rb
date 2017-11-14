class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :Title
      t.text :Description
      t.string :Username
      t.integer :number_of_likes, default: 0, index: true
      t.integer :number_of_hates, default: 0, index: true
      t.belongs_to :user, index: true



      t.timestamps null: false
    end
  end
end
