# DEVELOPMENT ENVIRONMENT SPECIFIC 
# -----------------------------------------------------------------
production:
  cas_url: 'https://sso.wvu.edu/cas/' 
  ssl: 'true' 
development:
  cas_url: https://ssodev.wvu.edu/cas/
  ssl: 'false'
  google_analytics_key: ~ #nullifies for dev
test:
  ssl: 'false'
  google_analytics_key: ~ #nullifies for test
