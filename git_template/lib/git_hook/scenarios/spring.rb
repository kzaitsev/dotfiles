module GitHook
  module Scenarios
    class Spring < Base
      def run
        puts 'Stopping spring'

        begin
          system("nohup spring stop > /dev/null 2>&1&")
        rescue StandardError
          exit 0
        end
      end
    end
  end
end
