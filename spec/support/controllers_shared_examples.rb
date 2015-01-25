RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
end
shared_context 'user signed in' do
  let!(:user) { create(:user, confirmed_at: Time.now) }
  before { sign_in user }
end

shared_context 'editor signed in' do
  let!(:editor) { create(:editor, confirmed_at: Time.now) }
  before { sign_in editor }
end

shared_context 'admin signed in' do
  let!(:admin) { create(:admin, confirmed_at: Time.now) }
  before { sign_in admin }
end
