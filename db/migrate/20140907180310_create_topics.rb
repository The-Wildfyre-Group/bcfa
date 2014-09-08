class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.belongs_to :forum
      t.string :name
      t.integer :last_poster_id
      t.datetime :last_post_at
      t.belongs_to :user
      t.timestamps
    end
  end
end
