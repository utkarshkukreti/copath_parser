require "bundler/gem_tasks"

require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new('spec')

# If you want to make this the default task
task :default => :spec

task :pry do
  system "pry -Ilib -r./lib/copath_parser -e 'include CopathParser'"
end
