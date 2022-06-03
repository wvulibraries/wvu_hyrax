# WVU Libraries Digital Repository

## RSPEC
We are using Rspec to handle the backend testing.

`RAILS_ENV=test bundle exec rspec` will run the full test
`RAILS_ENV=test bundle exec rspec {directory_path}` will run a specific subset of tests
`RAILS_ENV=test bundle exec rspec {directory_path}/{test_name}` will run a single test.