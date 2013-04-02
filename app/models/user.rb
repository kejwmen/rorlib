require 'bcrypt'
  # User data model
class User < ActiveRecord::Base
  attr_accessible :email, :first_name, :last_name, :permissions, :phone, :sex, :password, :password_confirmation
  attr_accessor :password
  
  # Runs encrypt_password method before saving entity
  before_save :encrypt_password
  
  # Validations. Needed identical password in both password boxes 
  validates :password, :confirmation => true
  # Validates presence of password
  validates_presence_of :password, :on => :create
  # Validates phone number with regular expression
  validates :phone, :presence  => true, :format => {:with => /^([0-9]{9})|(([0-9]{3}-){2}[0-9]{3})$/i, :message => "Niepoprawny numer telefonu"}
  # Validates email with regular expression
  validates :email, :uniqueness => {:case_sensitive => false}, :presence => true, :format => {
                :with    => /^([^\s]+)((?:[-a-z0-9]\.)[a-z]{2,})$/i,
                :message => "Niepoprawny adres" }
  # Validates presence of following attributes
  validates_presence_of :first_name, :last_name, :sex

  # Authenticate method. Compares stored password_hash with entered password. Both are hashed and salted.
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && (BCrypt::Password.new(user.password_hash).is_password? password)
      user
    else
      nil
    end
  end

  # Hash and salt password before insterting into database
  def encrypt_password
    if password.present?
      self.password_hash = BCrypt::Password.create(password)
    end
  end
end
