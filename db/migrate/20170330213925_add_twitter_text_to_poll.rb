class AddTwitterTextToPoll < ActiveRecord::Migration[5.0]
  def change
    add_column :polls, :twitter_text, :text
  end
end
