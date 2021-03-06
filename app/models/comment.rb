class Comment < ActiveRecord::Base
  extend ActiveModel::Naming
  include ActiveModel::Conversion

  belongs_to :user
  belongs_to :book

  scope :persisted, -> { where('id IS NOT NULL') }

  validates :rating, :description, :user_id, :book_id, presence: true
  validates :rating, numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 10}
  validate :first_comment_per_user_per_book?, on: :create

  def can_be_updated_or_deleted?(current_user)
    current_user == user
  end

  private

  def first_comment_per_user_per_book?
   if user && book.user_has_comment?(user)
      errors.add(:book_id, 'Cannot add more than one comment to each book per user')
    end
  end
end
