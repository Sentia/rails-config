#!/bin/bash
echo '--- Code Climate'
set -e

echo '--- Prepare Coverage Filder'
mkdir -p coverage

echo '--- Download Coverage results'
buildkite-agent artifact download "coverage/*" /

echo '--- Download Codeclimate'
curl -L https://codeclimate.com/downloads/test-reporter/test-reporter-latest-darwin-amd64 > ./cc-test-reporter

echo '--- Configure Permissions'
chmod +x ./cc-test-reporter

echo '--- Prebuild'
./cc-test-reporter before-build

echo '--- Format Coverage'
./cc-test-reporter format-coverage -t simplecov

echo '--- Upload Coverage'
./cc-test-reporter upload-coverage

echo '--- Finalising'
./cc-test-reporter after-build --exit-code 0
