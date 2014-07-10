class User < ActiveRecord::Base
  include Location
  has_secure_password
  #validates_presence_of :password, :on => :create
  #validates :first_name, :presence => true, length: {minimum: 2, maximum: 20}
  #validates :last_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :email, :presence => true
  #before_save { self.email = email.downcase }
  before_create { generate_token(:authentication_token) }
  #after_update :password_changed?, :on => :update
  #before_save :encrypt_password
  
  # user detail
  has_one :user_detail
  accepts_nested_attributes_for :user_detail, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :user_profile_pictures
  accepts_nested_attributes_for :user_profile_pictures, :reject_if => :all_blank, :allow_destroy => true
  
  attr_accessor :access_code
  
  def password_changed?
    if (provider.nil? || provider.try(:empty?))
      if password_digest_changed?
        # self.update_attributes(old_password: "example")
         Emails.password_changed(self).deliver
      end
    end
  end
  
  def encrypt_password 
    unless self.password.nil?
      self.password_digest = BCrypt::Password.create(self.password)
    end
  end
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def send_password_reset
    generate_token(:reset_password_token)
    self.reset_password_sent_at = Time.zone.now
    save!
    Emails.password_reset(self).deliver
  end
  
  def full_name
    [prefix_with_period, first_name.try(:capitalize), middle_initial_with_period, last_name_if, suffix, certification_suffixes ].compact.join(' ')
  end
  
  def last_name_if
    unless user_detail.try(:certifications).nil? || user_detail.try(:certifications).blank?
      "#{last_name.try(:capitalize)}, "
    else
      last_name.try(:capitalize)
    end
  end
  
  def certification_suffixes #TODO
    user_detail.try(:certifications).try(:upcase)
  end

  def middle_initial_with_period
    middle_initial = middle_name.split("").first.upcase unless middle_name.blank?
    "#{middle_initial}." unless middle_name.blank?
  end
  
  def prefix_with_period
    "#{prefix.capitalize}." unless prefix.blank?
  end
  
  def first_name_with_capital
    if first_name.nil? or first_name.blank?
      "Member"
    else
      first_name.capitalize
    end
  end
  
  def company_and_title
    unless user_detail.try(:title).nil? || user_detail.try(:title).blank?
      "#{user_detail.try(:title)}, #{user_detail.try(:company)}"
    else
      user_detail.try(:company)
    end
  end
  
  def avatar
    unless user_profile_pictures.blank?
      user_profile_pictures.last.try(:photo)
    else
      "http://www.clker.com/cliparts/A/Y/O/m/o/N/placeholder-md.png"
    end
  end
  
  
  
  
end
