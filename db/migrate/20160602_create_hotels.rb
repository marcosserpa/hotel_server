class CreateHotels < ActiveRecord::Migration
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.integer :star_rating
      t.string :accomotaion_type
    end
  end
end