class AddLevelToUsers < ActiveRecord::Migration
  def change
    add_column :users, :level, :string
    add_column :users, :verified, :boolean
  end
end
