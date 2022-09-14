echo "Preparing Database"
bin/rails db:create

# if schema.rb exists load schema else run the migrations
FILE=/home/hyrax/db/schema.rb
if [test -f "$FILE"]; then
    bin/rails db:schema:load
else
    bin/rails db:migrate
fi

bin/rails db:seed

