class AddUserNameToBallots < ActiveRecord::Migration[5.0]
  def change
    add_column :ballots, :user_name, :string
  end
end
