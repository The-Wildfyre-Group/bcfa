class CreateUserDetails < ActiveRecord::Migration
  def change
    create_table :user_details do |t|
      t.belongs_to :user
      
      ## Social media.
      t.string :linkedin
      t.string :facebook
      t.string :instagram
      t.string :twitter
      
      ## Education
      t.string :undergraduate_school
      t.string :graduate_school
      t.string :other_school
      t.string :undergraduate_degree
      t.string :graduate_degree
      t.string :other_degree
      
      ## Charter
      t.integer :year_of_charter
      
      ## Certs
      t.string :certifications
      
      ## Work, Industries
      t.string :company
      t.string :title
      t.string :industries
      
      ## Interests & Skills
      t.string :interests
      t.string :skills
      
      ## location
      t.string :city
      t.string :state
      t.string :zipcode
      
      t.text :bio 
      
      

      t.timestamps
    end
  end
end
