require 'yaml'

module GitHook
  module Scenarios
    class Rubocop < Base
      def initialize
        require_or_exit 'rubocop'
      end

      def run
        if filtered.empty?
          puts 'Rubocop skiped'
          exit 0
        else
          config_store = RuboCop::ConfigStore.new
          options, paths = RuboCop::Options.new.parse(filtered)
          runner = RuboCop::Runner.new(options, config_store)

          all_passed = runner.run(paths)

          exit_code = all_passed && !runner.aborting? && runner.errors.empty? ? 0 : 1
          exit exit_code
        end
      end

      private

      def filtered
        @filtered ||= FILES.select do |f|
          if local_rules.any? { |r| f.match(r) }
            false
          else
            RUBY_FILES.find do |rf|
              if f.match('Gemfile')
                false
              else
                f.match(rf)
              end
            end
          end
        end
      end

      def local_rules
        @local_rules ||= local_rules!
      end

      def local_rules!
        local_rubocop = File.join(Dir.pwd, '.rubocop.yml')

        if File.exist?(local_rubocop)
          yml = YAML.load_file(local_rubocop)

          excludes = if yml['AllCops'].is_a?(Hash) && yml['AllCops']['Exclude'].is_a?(Array)
                       yml['AllCops']['Exclude']
                     else
                       []
                     end

          yml.each_pair do |key, value|
            next unless key.to_s.match(/(Lint\/.*|Metrics\/.*|Style\/.*)/)

            if value.is_a?(Hash) && value['Exclude'].is_a?(Array)
              value['Exclude'].each do |exclude|
                excludes << exclude
              end
            end
          end

          excludes.map! do |exclude|
            if exclude.match('/\*\*/\*')
              Dir[exclude]
            else
              exclude
            end
          end

          excludes.flatten
        else
          []
        end
      end
    end
  end
end
