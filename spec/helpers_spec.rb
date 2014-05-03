require 'spec_helper'

describe 'Userbin helpers' do
  let(:token) { 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImlhdCI6MTM5ODIzOTIwMywiZXhwIjoxMzk4MjQyODAzfQ.eyJ1c2VyX2lkIjoiZUF3djVIdGRiU2s4Yk1OWVpvanNZdW13UXlLcFhxS3IifQ.Apa7EmT5T1sOYz4Af0ERTDzcnUvSalailNJbejZ2ddQ' }

  it 'creates a session' do
    Userbin::Session.should_receive(:create).
      and_return(Userbin::Session.new(id: token))
    Userbin.authenticate(user: {email: 'valid@example.com'})
  end

  it 'refreshes, and does not create a session' do
    Userbin::Session.should_not_receive(:create)
    Userbin::Session.any_instance.should_receive(:refresh).
      and_return(Userbin::Session.new(id: token))
    opts = {
      user_id: '1234',
      properties: {
        email: 'valid@example.com'
      },
      context: {
        ip: '8.8.8.8',
        user_agent: 'Mozilla'
      },
      current: token,
    }
    Userbin.authenticate(opts)
  end
end
