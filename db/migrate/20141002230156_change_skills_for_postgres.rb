class ChangeSkillsForPostgres < ActiveRecord::Migration
  def change
    change_column :user_details, :skills, :string, array: true, default: '{}'
  end
end
