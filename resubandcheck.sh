#!/bin/bash

for d in [0-9]*; do
  if [ -d "$d" ]; then
    mkdir -p "$d/passedJobs"
    (
      cd "$d" || exit

      # Move completed jobs to passedJobs/
      find . -name "*.stderr" -exec grep -l "errors = 0" {} + | while read -r file; do
        job_dir=$(dirname "$file")
        # Avoid moving if already in passedJobs
        if [[ "$job_dir" != ./passedJobs/* ]]; then
          mv "$job_dir" passedJobs/
        fi
      done

      echo "Remaining in $d/Jobs/:"
      if [ -d Jobs ] && [ "$(ls -A Jobs)" ]; then
        ls -1 Jobs/
        echo "Resubmitting in $d..."
        condor_submit condor_cluster.sub
      else
        echo "No Jobs/ directory or all moved"
      fi
      echo "--------"
    )
  fi
done

