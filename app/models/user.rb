class User < ActiveRecord::Base
  include Location
  has_secure_password
  #validates_presence_of :password, :on => :create
  #validates :first_name, :presence => true, length: {minimum: 2, maximum: 20}
  #validates :last_name, :presence => true, length: {minimum: 2, maximum: 20}
  validates :email, :presence => true
  #before_save { self.email = email.downcase }
  before_create { generate_token(:authentication_token) }
  after_update :password_changed?, :on => :update
  #before_save :encrypt_password
  # validate :check_access_code, :on => :create
 # before_update :set_old_password, :on => :update
  #validate :check_old_password, :on => :update
  
  
  # user detail
  has_one :user_detail
  accepts_nested_attributes_for :user_detail, :reject_if => :all_blank, :allow_destroy => true
  
  has_many :user_profile_pictures
  accepts_nested_attributes_for :user_profile_pictures, :reject_if => :all_blank, :allow_destroy => true
  
  ACCESS_CODE = ["charterme", "5678", "spa", "live", "blck", "dc", "cordis"]
  
  attr_accessor :access_code, :current_password, :old_password
  
  def check_access_code
    unless ACCESS_CODE.include? access_code
      errors.add(:access_code, "Error: Access Code is Incorrect.")
    end
  end
  
  def password_changed?
    if password_digest_changed?
      # self.update_attributes(old_password: "example")
       Email.password_changed(self).deliver
    end
  end
  
  def set_old_password
    unless current_password.blank?
      if self == self.authenticate(current_password)
        logger.info "password is a match"
        password = nil
        password_confirmation = nil
      else
        logger.info "password is NOT a match"
      end
    end
  end
  
  def check_old_password
    unless password.blank?
      unless self == self.authenticate(current_password)
        errors.add(:current_password, "Error: Current Password is Incorrect.")
        logger.info "Error: Current Password is Incorrect."
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
    if user_profile_pictures.last.try(:id).blank?
      "http://www.imcslc.ca/imc/includes/themes/imc/images/layout/img_placeholder_avatar.jpg"
    else
      user_profile_pictures.last.photo
    end
  end
  
  def undergraduate_alma_mater
    [user_detail.try(:undergraduate_school), undergraduate_formatted_year].compact.join(' ') if user_detail.undergraduate_school.present?
  end
  
  def graduate_alma_mater
    [user_detail.try(:graduate_school), graduate_formatted_year].compact.join(' ') if user_detail.graduate_school.present?
  end
  
  def doctorate_alma_mater
    [user_detail.try(:doctorate_school), doctorate_formatted_year].compact.join(' ') if user_detail.doctorate_school.present?
  end
  
  def undergraduate_formatted_year
    "'#{user_detail.try(:undergraduate_year).to_s.last(2)}" if user_detail.undergraduate_year.present?
  end
  
  def graduate_formatted_year
    "'#{user_detail.try(:graduate_year).to_s.last(2)}" if user_detail.graduate_year.present?
  end
  
  def doctorate_formatted_year
    "'#{user_detail.try(:doctorate_year).to_s.last(2)}" if user_detail.doctorate_year.present?
  end
  
  def undergratuate_degree_and_major
    delimiter = user_detail.try(:undergraduate_degree).present? ? ", " : ""
    [user_detail.try(:undergraduate_degree),user_detail.try(:undergraduate_major)].compact.join(delimiter) if user_detail.try(:undergraduate_major).present?
  end
  
  def graduate_degree_and_major
    delimiter = user_detail.try(:graduate_degree).present? ? ", " : ""
    [user_detail.try(:graduate_degree),user_detail.try(:graduate_major)].compact.join(delimiter) if user_detail.try(:graduate_major).present?
  end
  
  def doctorate_degree_and_major
    delimiter = user_detail.try(:doctorate_degree).present? ? ", " : ""
    [user_detail.try(:doctorate_degree),user_detail.try(:doctorate_major)].compact.join(delimiter) if user_detail.try(:doctorate_major).present?
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
    Email.password_reset(self).deliver
  end
  
  
  
  
end
