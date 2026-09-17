#!/usr/bin/env bash
set -euo pipefail                                                # stop on any error
# headless review: diff in on stdin, JSON findings out
git diff "origin/${BASE_BRANCH:-main}...HEAD" | claude -p "/review" --output-format json --json-schema "$(cat .claude/findings.schema.json)" --allowedTools "Read,Grep,Glob" --max-turns 10 > review.json
jq -e '.is_error == false' review.json > /dev/null               # fail the job if the run errored
CRITICAL=$(jq '[.structured_output.findings[] | select(.severity == "critical")] | length' review.json)   # count critical findings
echo "critical findings: $CRITICAL"                              # visible in CI logs
[ "$CRITICAL" -eq 0 ]                                            # non-zero exit blocks the merge
