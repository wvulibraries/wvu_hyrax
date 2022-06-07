# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
ENV["RACK_ENV"] ||= ENV["ENVIRONMENT"] ||= "test"

if ENV["COVERAGE"]
  require "simplecov"
  require "simplecov_json_formatter"

  SimpleCov.formatter = SimpleCov::Formatter::JSONFormatter

  SimpleCov.start do
    add_group "lib", "lib"
    add_group "spec", "spec"

    maximum_coverage_drop 2
    # FIXME: JRuby reports different coverage on multi-line boolean statements like in `dead_job.rb`
    minimum_coverage_by_file 70 # 95
    minimum_coverage 95
  end
end

RSpec.configure do |config|
  # expectations
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  # mocks
  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # alternative configs
  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.default_formatter = 'doc'
  config.order = :random

  # remove testing files
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/tests/data"])
  end  
end
