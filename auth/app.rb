# frozen_string_literal: true

require 'sinatra'
require 'sinatra/json'
require 'jwt'

HMAC_SECRET = 's3cr3t'

user = {
  email: 'dev@example.org',
  password: 'test'
}

before do
  request.body.rewind
  @request_payload = JSON.parse(request.body.read, symbolize_names: true)
end

post '/v1/auth' do
  email, password = @request_payload.values_at(:email, :password)

  unless user[:email] == email && user[:password] == password
    halt 400, { errors: { message: 'invalid_username_or_password' } }.to_json
  end

  token = JWT.encode(@request_payload, HMAC_SECRET, 'HS256')
  json token: token
end

post '/v1/token' do
  token_decoded = JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS256')
  json token: 'my-token'
end
