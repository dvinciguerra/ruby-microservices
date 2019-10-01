# frozen_string_literal: true

require 'jwt'
require 'sinatra'
require 'sinatra/json'

require './lib/auth/repository/user_repository'

HMAC_SECRET = ENV.fetch('HMAC_SECRET') { 's3cr3t' }

before do
  request.body.rewind
  @request_payload = JSON.parse(request.body.read, symbolize_names: true)
end

post '/v1/auth' do
  email, password = @request_payload.values_at(:email, :password)

  user = Auth::Repository::UserRepository.authenticate(email: email, password: password)

  halt(401) unless user

  token = JWT.encode(user.to_h, HMAC_SECRET, 'HS256')
  json token: token
end

post '/v1/validate-token' do
  token = @request_payload[:token]
  payload, _metadata = JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS256')

  json id: payload['id'], email: payload['email']
rescue JWT::VerificationError
  halt 401
end
