class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :rating
      t.text :body
      t.references :work, foreign_key: true

      t.timestamps
    end
  end
end
