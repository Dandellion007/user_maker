#!/bin/bash
set -e

echo "Environment: $RAILS_ENV"

mkdir -p log
touch log/test.log

cmd=$@

if [[ "${1:-unset}" == "unset" ]]; then
  cmd="tail -f log/test.log"
fi

echo "$cmd"
$cmd
