class AddSlugToUsers < ActiveRecord::Migration
  def change
    add_column :users, :slug, :string
    
    User.all.each do |user|
      slug = user.apply_slug_to_existing
      user.update_attributes(slug: slug)
    end
  end
end
