#!/bin/bash
cd ~/conda-envs || exit 1
mkdir -p exports

for env in $(conda env list | awk '{print $1}' | grep -v "#" | grep -v "base"); do
    echo "Exporting $env..."
    conda env export -n "$env" --no-builds > "exports/$env.yml"
done

git add exports/*.yml
git commit -m "Update Conda envs"
git push

