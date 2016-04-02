require 'set'

module GitHook
  module Scenarios
    class Brakeman < Base
      def initialize
        require_or_exit 'brakeman'
      end

      def run
        unless is_a_rails?
          LOGGER.success 'Brakeman skipped (non-rails app)'
          exit 0
        end

        if filtered.empty?
          LOGGER.success 'Brakeman skipped (nothing to do)'
          exit 0
        else
          options = {only_files: filtered.to_set, app_path: Dir.pwd, exit_on_warn: true}

          ::Brakeman.run(options.merge(print_report: true, quiet: true))
        end
      end

      private

      def filtered
        @filtered ||= FILES.select do |f|
          RUBY_FILES.find do |rf|
            f.match(rf)
          end
        end
      end
    end
  end
end
