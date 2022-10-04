class AddColumnOnlineToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :online, :integer, default: 0
  end
end
