class Topic < ActiveRecord::Base
  belongs_to :forum
  has_many :posts, :dependent => :destroy
  belongs_to :user
  has_one :visit, :as => :visitable
  
  # forum
  has_many :posts
  accepts_nested_attributes_for :posts, :reject_if => :all_blank, :allow_destroy => true
  
end
