class AttemptToGetArrayWorkingInPg < ActiveRecord::Migration
  def change
    change_column :user_details, :skills, :string, array: true, default: Array[]
  end
end
