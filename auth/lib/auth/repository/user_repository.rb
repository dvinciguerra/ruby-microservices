# frozen_string_literal: true

require_relative '../entity/user'

module Auth
  module Repository
    class UserRepository
      @users = [
        { email: 'dev@example.org', password: 'test' }
      ]

      def self.authenticate(email:, password:)
        user_data = @users.find do |user|
          user[:email] == email && user[:password] == password
        end

        return nil unless user_data

        Auth::Entity::User.new(user_data)
      end
    end
  end
end
