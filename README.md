# WVU Libraries Digital Repository

[![CircleCI](https://circleci.com/gh/wvulibraries/wvu_hyrax.svg?style=svg)](https://circleci.com/gh/wvulibraries/wvu_hyrax)
[![Maintainability](https://api.codeclimate.com/v1/badges/489d6dd7c8e887743a1e/maintainability)](https://api.codeclimate.com/v1/badges/489d6dd7c8e887743a1e/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/489d6dd7c8e887743a1e/test_coverage)](https://api.codeclimate.com/v1/badges/489d6dd7c8e887743a1e/test_coverage)

## RSPEC
We are using Rspec to handle the backend testing.

`RAILS_ENV=test bundle exec rspec` will run the full test
`RAILS_ENV=test bundle exec rspec {directory_path}` will run a specific subset of tests
`RAILS_ENV=test bundle exec rspec {directory_path}/{test_name}` will run a single test.