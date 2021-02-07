#!/bin/bash

set -ex

cd /workspace

if [ ! -e api ]; then
  git clone --recursive https://gitlab.com/vini.freire.oliveira/micro-api.git
fi

cd api

if [ ! -e config/sidekiq.yml ]; then
  ln -s ../../.docker/api/config/sidekiq.yml config/sidekiq.yml
fi

unset BUNDLE_APP_CONFIG

bundle config set path '/gems'

bundle install

exec "$@"