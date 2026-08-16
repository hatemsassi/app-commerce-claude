#!/bin/bash
input=$(cat)
if printf '%s' "$input" | grep -q "@Autowired"; then
  echo "BLOCKED: @Autowired found. Use @RequiredArgsConstructor instead." >&2
  exit 2
fi
exit 0