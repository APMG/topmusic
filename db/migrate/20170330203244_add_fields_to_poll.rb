class AddFieldsToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :long_title, :string
    add_column :polls, :description, :text
  end
end
