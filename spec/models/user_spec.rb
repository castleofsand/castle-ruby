require 'spec_helper'

describe 'Castle::User' do
  it 'retrieves a user' do
    VCR.use_cassette('user_find') do
      user = Castle::User.find('9RA2j3cYDxt8gefQUduKnxUxRRGy6Rz4')
      user.email.should == 'brissmyr@gmail.com'
    end
  end

  it 'handles non-existing user' do
    VCR.use_cassette('user_find_non_existing') do
      error = nil
      begin
        user = Castle::User.find('non_existing')
      rescue Castle::Error => e
        error = e
      end
      error.to_s.should match /Not found/
    end
  end

  it 'updates a user' do
    VCR.use_cassette('user_update') do
      user = Castle::User.new(id: 'AKfwtfrAzdDKp55aty8o14MoudkaS9BL')
      user.email = 'updated@example.com'
      user.created_at = Time.now
      user.save
    end
  end
end
