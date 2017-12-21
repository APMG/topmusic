class MakeBallotPublicUidUnique < ActiveRecord::Migration[5.0]
  def change
    add_index :ballots, :public_uid, unique: true
  end
end
