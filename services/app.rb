# frozen_string_literal: true

require 'http'
require 'sinatra'
require 'sinatra/json'

AUTH_SERVICE_ENDPOINT = ENV.fetch('AUTH_SERVICE_ENDPOINT') { 'http://localhost:3001/v1/validate-token' }

before do
  request.body.rewind
  @request_payload = JSON.parse(request.body.read, symbolize_names: true)

  response = HTTP.post(
    'http://localhost:3001/v1/validate-token', json: { token: request.env['HTTP_AUTHORIZATION'].split(' ').last }
  )
  halt(401) unless response.status.success?
end

post '/v1/services' do
  status 201
  json @request_payload
end
