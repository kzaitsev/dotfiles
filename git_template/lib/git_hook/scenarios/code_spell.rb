require 'open3'

module GitHook
  module Scenarios
    class CodeSpell
      CODE_SPELL_BIN = [
        "#{ENV['HOME']}/.codespell/codespell.py",
        ENV['CODE_SPELL_BIN'].to_s
      ]

      def initialize
        if executable.nil?
          LOGGER.bold_warning 'CodeSpell not installed: https://github.com/lucasdemarchi/codespell'
          exit 0
        end
      end

      def run
        if FILES.empty?
          LOGGER.success 'CodeSpell skiped (nothing to do)'
          exit 0
        end

        output = IO.popen([executable, '-c', FILES].flatten.join(' '))

        res = output.readlines.reject do |line|
          line.match(/^WARNING: Binary file:/)
        end

        if res.empty?
          exit 0
        else
          puts res
          exit 1
        end
      end

      private

      def executable
        @executable ||= CODE_SPELL_BIN.find do |bin|
          next if bin.empty?
          File.exist?(bin)
        end
      end
    end
  end
end
