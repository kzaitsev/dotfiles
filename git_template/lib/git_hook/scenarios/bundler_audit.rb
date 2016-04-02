module GitHook
  module Scenarios
    class BundlerAudit < Base
      def initialize
        require_or_exit 'bundler/audit/cli'
      end

      def run
        if FILES.grep(/Gemfile(\.lock|)/).empty?
          puts 'skip bundler audit'
          exit 0
        else
          Bundler::Audit::CLI.start
        end
      end
    end
  end
end
