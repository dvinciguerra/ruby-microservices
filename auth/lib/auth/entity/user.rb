# frozen_string_literal: true

module Auth
  module Entity
    class User
      attr_accessor :email, :password

      def initialize(**props)
        @email = props[:email]
        @password = props[:password]
      end

      def to_h
        {
          email: @email,
          password: @password
        }
      end
    end
  end
end
