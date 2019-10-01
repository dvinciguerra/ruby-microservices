# frozen_string_literal: true

module Auth
  module Entity
    class User
      attr_accessor :id, :email, :password

      def initialize(**props)
        @id = props[:id]
        @email = props[:email]
        @password = props[:password]
      end

      def to_h
        {
          id: @id,
          email: @email,
          password: @password
        }
      end
    end
  end
end
