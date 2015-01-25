class Author < ActiveRecord::Base
  has_many :books

  validates :first_name, :last_name, :age, :country, presence: true
  validates :age, numericality: {only_integer: true}

  def to_s
    "#{first_name} #{last_name}"
  end
end
