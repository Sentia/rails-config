#!/bin/bash
source "$HOME/.bashrc"

echo '--- bundling'
bundle install
yarn install

echo '--- preparing database'
./bin/rails db:create RAILS_ENV=test
./bin/rails db:migrate RAILS_ENV=test

echo '--- running specs'
./bin/rspec
result=$?

echo '--- upload coverage results'
buildkite-agent artifact upload "coverage/.resultset.json"

exit $result
