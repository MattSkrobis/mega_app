require 'rails_helper'

describe Avatar do
  it {should validate_presence_of(:name)}
  it {should validate_presence_of(:user_id)}
end
