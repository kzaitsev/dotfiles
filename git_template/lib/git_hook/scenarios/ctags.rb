module GitHook
  module Scenarios
    class Ctags < Base
      def run
        LOGGER.bold 'Genrate ctags'

        begin
          tags = File.join('.git', 'tags')

          File.delete(tags) if File.exist?(tags)

          system("nohup /usr/local/bin/ctags -R * > /dev/null 2>&1&")
        rescue StandardError
          exit 0
        end
      end
    end
  end
end
