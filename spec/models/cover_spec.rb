require 'rails_helper'

describe Cover do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:book_id) }
end
