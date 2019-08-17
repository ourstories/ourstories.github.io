#!/bin/bash

script_dir="$(dirname $0)"
root_dir="${script_dir}/.."

for i in $(find "$root_dir" -name "*.asc")
do
  i_dir="$(dirname $i)"
  cleartext="${i_dir}/$(egrep "Comment: source " $i | dos2unix | awk '{print $3}')"
  "${script_dir}/encrypt.sh" "$cleartext"  
done
