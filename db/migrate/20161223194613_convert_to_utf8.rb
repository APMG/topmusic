class ConvertToUtf8 < ActiveRecord::Migration[5.0]
  def change
    execute 'ALTER TABLE `ballots` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin'
    execute 'ALTER TABLE `polls` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin'
    execute 'ALTER TABLE `selections` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin'
    execute 'ALTER TABLE `songs` CONVERT TO CHARACTER SET utf8mb4 COLLATE utf8mb4_bin'
  end
end
