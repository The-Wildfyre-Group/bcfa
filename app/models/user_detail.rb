class UserDetail < ActiveRecord::Base
  include Location
  belongs_to :user
  
  def social_media?
    [twitter.present?, facebook.present?, linkedin.present?, instagram.present?].include? true
  end
end
