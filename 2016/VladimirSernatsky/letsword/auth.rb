module Sinatra
  module Auth
    module Helpers
      def logged_in?
        !session["user_id"].nil?
      end
    end
    def self.registered(app)
      app.helpers Auth::Helpers
      app.set :auth do |x|
        condition do
          if logged_in?
            @user = User.find_by(id: session["user_id"])
          else
            redirect to "/login"
          end
        end
      end
      app.set :unauth do |x|
        condition do
          if logged_in?
            redirect to "/list"
          end
        end
      end
    end
  end
  register Auth
end
