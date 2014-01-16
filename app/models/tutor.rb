class Tutor < ActiveRecord::Base
  belongs_to :site
  has_many :students
  has_many :lesson_plans
  has_many :homeworks, through: :lesson_plans
  has_secure_password
  validates :email, presence: true, 
                    uniqueness: { case_sensitive: false }
  # validates :password, length: { minimum: 8 }

  before_create :create_remember_token
  before_save { self.email = email.downcase }

  def Tutor.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def Tutor.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end




  private

    def create_remember_token
      self.remember_token = Tutor.encrypt(Tutor.new_remember_token)
    end
end
