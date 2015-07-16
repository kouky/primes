#!/usr/bin/env bash
set -eu

export PARALLEL_JOB="${BUILDKITE_PARALLEL_JOB:-0}"
export PARALLEL_JOB_COUNT="${BUILDKITE_PARALLEL_JOB_COUNT:-1}"

ruby primes.rb
