class CreatePolls < ActiveRecord::Migration[5.0]
  def change
    create_table :polls do |t|
      t.string :slug
      t.string :name
      t.string :selectable
      t.datetime :open_date
      t.datetime :close_date

      t.timestamps
    end
  end
end
