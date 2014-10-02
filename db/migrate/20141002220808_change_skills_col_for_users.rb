class ChangeSkillsColForUsers < ActiveRecord::Migration
  def change
    remove_column :user_details, :skills
    add_column :user_details, :skills, :string, array: true, default: []
  end
end
