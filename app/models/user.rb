require 'bcrypt'
class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :permissions, :phone, :sex, :password, :password_confirmation

  attr_accessor :password
  before_save :encrypt_password

  validates :password, :confirmation => true
  validates_presence_of :password, :on => :create

  validates :phone, :presence  => true, :format => {:with => /^([0-9]{9})|(([0-9]{3}-){2}[0-9]{3})$/i, :message => "Niepoprawny numer telefonu"}
  validates :email, :uniqueness => {:case_sensitive => false}, :presence => true, :format => {
                :with    => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
                :message => "Niepoprawny adres" }

  validates_presence_of :first_name, :last_name, :sex

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && BCrypt::Password.new(user.password_hash).is_password? password
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_hash = BCrypt::Password.create(password)
    end
  end
end
