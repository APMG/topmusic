class BallotPublicUidNotNullable < ActiveRecord::Migration[5.0]
  def change
    change_column_null :ballots, :public_uid, false
  end
end
