desc 'Run metrics with Heckle'
task :ci => %w[ ci:metrics heckle ]

# Make sure vertias is loaded before metric_fu infects datetime via active_support
require 'veritas'

namespace :ci do
  desc 'Run metrics'
  task :metrics => %w[ verify_measurements flog flay reek roodi metrics:all ]
end
