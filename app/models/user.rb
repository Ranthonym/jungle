class User < ActiveRecord::Base
  
  has_secure_password

  validates :email, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :password, length: { minimum: 6 }

  before_save :normalize_email 

  def self.authenticate_with_credentials(email, password)
    user = User.find_by_email(email.downcase.strip)
    user && user.authenticate(password)
  end
  
  private
  def normalize_email
    self.email = email.downcase.strip
  end

end
