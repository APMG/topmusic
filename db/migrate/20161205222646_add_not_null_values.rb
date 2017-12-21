class AddNotNullValues < ActiveRecord::Migration[5.0]
  def change
    change_column_null :ballots, :user_id, false
    change_column_null :ballots, :poll_id, false
  end
end
