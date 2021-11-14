class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.references :category, index: true, foreign_key: true
      t.integer :status, null: false, index: true
      t.string :name, null: false
      t.text :description, null: false

      t.timestamps
    end
  end
end
