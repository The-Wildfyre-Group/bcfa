class CreateVisits < ActiveRecord::Migration
  def change
    create_table :visits do |t|
      t.integer :visitable_id, :null => false
      t.string :visitable_type, :null => false
      t.integer :total_visits
      t.integer :unique_visits
      t.string :controller, :null => false
      t.string :action, :null => false
      t.timestamps
    end
    add_index :visits, :visitable_id
    add_index :visits, :visitable_type
    add_index :visits, :controller
    add_index :visits, :action
  end
end
