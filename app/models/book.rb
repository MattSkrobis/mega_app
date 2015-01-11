class Book < ActiveRecord::Base
  has_one :cover
  has_many :comments

  EDITIONS = %w(Softcover Hardcover E-Book)

  validates :title, :author, :publisher, :edition, :genre, :description, presence: true

  def self.editions_for_select
    EDITIONS.map {|edition| [edition, edition]}
  end

  def to_s
    "#{title}"
  end
end
