module GitHook
  module Scenarios
    class BundlerAudit < Base
      def initialize
        require_or_exit 'bundler/audit/cli'
      end

      def run
        if FILES.grep(/Gemfile(\.lock|)/).empty?
          LOGGER.success 'Bundler Audit skipped (nothing to do)'
          exit 0
        else
          Bundler::Audit::CLI.start
        end
      end
    end
  end
end
