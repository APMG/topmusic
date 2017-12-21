class CreateBallots < ActiveRecord::Migration[5.0]
  def change
    create_table :ballots do |t|
      t.string :user_id
      t.references :poll, foreign_key: true
      t.string :public_uid

      t.timestamps
    end
  end
end
