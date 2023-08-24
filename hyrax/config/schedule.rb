# set environmentals
ENV.each { |k, v| env(k, v) }

# set logs and environment
set :output, {:standard => "#{path}/log/cron.log", :error => "#{path}/log/cron_error.log"}
set :environment, ENV['RAILS_ENV']

# clobber the tmp folder daily and logs to keep files small 
every 1.day do
  command "cd #{path} && rake log:clear"
  command "cd #{path} && bin/rails tmp:clear"
end

fixity_audit:
  cron: "05 01 * * 6"
  class: FixityAuditJob
  rails_env: development
  queue: fixity
  description: "Run weekly fixity checks on all files in the repository"
  