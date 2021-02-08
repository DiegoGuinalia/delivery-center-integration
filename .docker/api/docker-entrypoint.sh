#!/bin/bash

set -ex

cd /workspace/api

unset BUNDLE_APP_CONFIG

bundle config set path '/gems'

bundle install

exec "$@"