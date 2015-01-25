class Publisher < ActiveRecord::Base
  has_many :books

  validates :name, :country, :email, :phone, presence: true

  def to_s
    "#{name}"
  end
end
