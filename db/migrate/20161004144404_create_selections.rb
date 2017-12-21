class CreateSelections < ActiveRecord::Migration[5.0]
  def change
    create_table :selections do |t|
      t.references :ballot, foreign_key: true
      t.references :song, foreign_key: true
      t.string :freeform

      t.timestamps
    end
  end
end
