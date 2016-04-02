$:.unshift(File.dirname(__FILE__))

require 'git_hook/scenarios'

module GitHook
  SKIP = ENV['SKIP'].to_s.split(',')
  RUBY_FILES = ['Rakefile', 'Gemfile', 'Capfile', 'Thorfile', 'Podfile', 'config.ru', /.*\.rake/, /.*\.cap/, /.*\.rb/]
  RAILS_FILES = ['config.ru', 'config/application.rb', 'config/environment.rb']
  FILES = `git diff --cached --name-only --diff-filter=ACM`.to_s.split("\n").map(&:strip)
  SCENARIOS = {
    rubocop: GitHook::Scenarios::Rubocop,
    brakeman: GitHook::Scenarios::Brakeman,
    bundler_audit: GitHook::Scenarios::BundlerAudit,
    ctags: GitHook::Scenarios::Ctags,
    spring: GitHook::Scenarios::Spring
  }

  class << self
    def pre_commit
      scenarios = [:rubocop, :brakeman, :bundler_audit]

      spawn_scenarios(scenarios)
    end

    def post_commit
      scenarios = [:spring, :ctags]

      spawn_scenarios(scenarios)
    end

    def post_checkout
      scenarios = [:spring, :ctags]

      spawn_scenarios(scenarios)
    end

    private

    def spawn_scenarios(scenarios)
      pids = []
      scenarios.select! do |scenario|
        if scenario_exist?(scenario)
          true
        else
          puts "unsupported #{scenario}"
          false
        end
      end

      scenarios.each do |scenario|
        if SKIP.include?('all') || SKIP.include?(scenario.to_s)
          puts "#{scenario} skipped"
          next
        end

        pids << fork do
          klass = SCENARIOS[scenario]
          scenario_class = klass.new
          scenario_class.run
        end
      end

      exit_status = 0
      pids.each do |pid|
        _, status = Process.wait2(pid)
        exit_status = status.exitstatus if status.exitstatus > 0
      end

      exit exit_status
    end

    def scenario_exist?(scenario)
      SCENARIOS.any? do |key, _|
        key == scenario.to_sym
      end
    end
  end
end
