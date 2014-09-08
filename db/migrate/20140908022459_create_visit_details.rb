class CreateVisitDetails < ActiveRecord::Migration
  def change
    create_table :visit_details do |t|
      t.belongs_to :visit, :null => false
      t.string :ip_address
      t.string :email
      t.timestamps
    end
    add_index :visit_details, :visit_id
  end
end
