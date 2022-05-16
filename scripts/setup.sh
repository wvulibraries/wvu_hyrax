echo "Preparing Database"
bin/rails db:create
bin/rails db:schema:load
bin/rails db:seed