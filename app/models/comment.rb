class Comment < ActiveRecord::Base
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  belongs_to :user
  belongs_to :book

  validates :rating, :description, :user_id, :book_id, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 10}
end
