class Book < ActiveRecord::Base
  has_many :comments
  belongs_to :author
  belongs_to :publisher

  has_attached_file :avatar, styles: {medium: "300x300>", thumb: "100x100>"}, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  EDITIONS = %w(Softcover Hardcover E-Book)

  validates :title, :author_id, :publisher_id, :edition, :genre, :description, presence: true

  def self.editions_for_select
    EDITIONS.map { |edition| [edition, edition] }
  end

  def to_s
    "#{title}"
  end
end
