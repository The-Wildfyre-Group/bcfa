class Visit < ActiveRecord::Base
  belongs_to :visitable, :polymorphic => true
  has_many :visit_details
  
  class << self
  def track(obj, controller, action, ip_address, *email)
      #visit = Visit.find_or_create_by_visitable_id_and_visitable_type(obj.id, obj.class.name)
      visit = Visit.where(visitable_id: obj.id, controller: controller, action: action, visitable_type: obj.class.name).first_or_create!
      ### check if visit is unique
      unless VisitDetail.where(visit_id: visit.id, ip_address: ip_address, email: email)
           visit.increment!(:unique_visits)
      end
      visit.increment!(:total_visits)
      visit_detail = visit.visit_details.create(:ip_address => ip_address, :email => email)
    end
    #handle_asynchronously :track, :run_at => Proc.new { 10.seconds.from_now }
  
  end
end