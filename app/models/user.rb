class User < ActiveRecord::Base
  has_many :comments

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, :encrypted_password, presence: true
  validates :first_name, :last_name, :nickname, :age, :country, presence: true, on: :update
  validates :age, numericality: {only_integer: true}, on: :update

  def to_s
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def editor?
    role == 'editor'
  end
end
