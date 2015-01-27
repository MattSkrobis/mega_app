require 'rails_helper'

describe Comment do
  it { should validate_presence_of(:description) }
  it { should validate_numericality_of(:rating).is_greater_than(0).is_less_than_or_equal_to(10) }
  it { should validate_presence_of(:rating) }
  it { should belong_to(:book) }
  it { should belong_to(:user) }
end
