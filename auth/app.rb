# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'jwt'

require './lib/auth/repository/user_repository'

HMAC_SECRET = ENV.fetch('HMAC_SECRET') { 's3cr3t' }

before do
  request.body.rewind
  @request_payload = JSON.parse(request.body.read, symbolize_names: true)
end

post '/v1/auth' do
  email, password = @request_payload.values_at(:email, :password)

  user = Auth::Repository::UserRepository.authenticate(email: email, password: password)
  unless user
    halt 400, { errors: { message: 'invalid_username_or_password' } }.to_json
  end

  token = JWT.encode(user.to_h, HMAC_SECRET, 'HS256')
  json token: token
end

post '/v1/token' do
  token = ''
  payload, _metadata = JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS256')

  unless payload[:email] == email && user[:password] == password
    halt 400, { errors: { message: 'invalid_username_or_password' } }.to_json
  end

  json token: 'my-token'
end
