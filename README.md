# Travel Intelligence Reference Data

## Installation

    bundle install
    cd spec/test_app
    ../../bin/rake ti_refdata:install:migrations
    ../../bin/rake db:migrate
    RAILS_ENV=test ../../bin/rake db:setup
    cd ../..
    ./bin/rspec
