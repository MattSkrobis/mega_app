class Cover < ActiveRecord::Base
  belongs_to :book

  validates :name, :book_id, presence: true
end
