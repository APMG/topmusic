class BallotUniqueConstraint < ActiveRecord::Migration[5.0]
  def change
    add_index :ballots, [:user_id, :poll_id], unique: true
  end
end
