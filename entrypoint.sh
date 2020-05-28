#!/bin/sh

# cd or fail
cd "$GITHUB_WORKSPACE" || exit 1

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

detekt --fail-fast --config "${INPUT_DETEKT_CONFIG}" --report xml:detekt_report.xml --excludes '**/build/**,**/.idea/**' \
  --plugins /opt/detekt-formatting-1.9.1.jar
reviewdog -f=checkstyle -name="detekt" -reporter="${INPUT_REPORTER}" -level="${INPUT_LEVEL}" -filter-mode=nofilter < detekt_report.xml