#!/bin/bash
source "$HOME/.bashrc"

echo '--- bundling'
bundle install
npm install

echo '--- preparing database'
./bin/rake db:create RAILS_ENV=test
./bin/rake db:test:prepare

echo '--- running specs'
./bin/rspec

echo '--- upload coverage results'
buildkite-agent artifact upload "coverage/.resultset.json"
