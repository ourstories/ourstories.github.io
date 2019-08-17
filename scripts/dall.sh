#!/bin/bash

script_dir="$(dirname $0)"
root_dir="${script_dir}/.."

for i in $(find "$root_dir" -name "*.asc")
do
  "${script_dir}/decrypt.sh" "$i"
done
