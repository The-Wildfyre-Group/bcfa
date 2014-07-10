class UserDetail < ActiveRecord::Base
  include Location
  belongs_to :user
end
