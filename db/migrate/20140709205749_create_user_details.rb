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
      t.string :doctorate_school
      t.string :undergraduate_degree
      t.string :graduate_degree
      t.string :doctorate_degree
      t.string :undergraduate_major
      t.string :graduate_major
      t.string :doctorate_major
      t.integer :undergraduate_year
      t.integer :graduate_year
      t.integer :doctorate_year
      
      ## Charter
      t.integer :year_of_charter
      
      ## Certs
      t.string :certifications
      
      ## Work, Industries
      t.string :company
      t.string :title
      t.string :industries
      t.string :website
      
      ## Interests & Skills
      t.string :interests
      t.string :skills
      
      ## location
      t.string :city
      t.string :state
      t.string :zipcode
      
      t.text :bio 
      
      #contact
      t.string :phone_number
      

      t.timestamps
    end
  end
end
