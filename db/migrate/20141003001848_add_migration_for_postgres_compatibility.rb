class AddMigrationForPostgresCompatibility < ActiveRecord::Migration
  def change
    change_column :user_details, :skills, :string
  end
end
