#!/bin/bash
input=$(cat)
extract() {
  echo "$input" | grep -o '"'"$1"'":[^,}]*' | grep -o '"[^"]*"$' | tr -d '"' | head -1
}
tool=$(extract "tool_name")
path=$(extract "file_path")
alt=$(extract "path")
resolved="${path:-${alt:-(no path)}}"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] ${tool:-(unknown)} -> $resolved" >> .claude/logs/file-activity.log
exit 0