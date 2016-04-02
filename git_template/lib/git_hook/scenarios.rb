module GitHook
  module Scenarios

    class Base
      def run
        raise "#{self.class.name}.run not implemented"
      end

      private

      def is_a_rails?
        RAILS_FILES.all? { |f| File.exist?(f) }
      end

      def rubygems_require
        @rubygems ||= begin
                        require 'rubygems'
                      end
      end

      def require_or_exit(dependency, exit_code = 1)
        begin
          rubygems_require
          require dependency
        rescue LoadError
          LOGGER.bold_warning "#{dependency} not installed"
          exit exit_code
        end
      end
    end
  end
end

require 'git_hook/scenarios/rubocop'
require 'git_hook/scenarios/brakeman'
require 'git_hook/scenarios/bundler_audit'
require 'git_hook/scenarios/ctags'
require 'git_hook/scenarios/spring'
require 'git_hook/scenarios/code_spell'
