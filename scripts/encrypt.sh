#!/bin/bash
cleartext=$1
path=$(dirname $cleartext) || exit
cyphertext=$(egrep "Comment: target " $1 | dos2unix | awk '{print $3}')
source=$(realpath --relative-to="${path}/$(dirname cyphertext)" "$cleartext")
cyphertext="${path}/${cyphertext}"
script="s#^-----BEGIN PGP MESSAGE-----#-----BEGIN PGP MESSAGE-----\nComment: source $source#"
if [[ -f "${cyphertext}" ]] && diff -d > /dev/null <( gpg2 -q -o- -d "${cyphertext}" ) "$cleartext"
then
  echo "Nothing to encrypt, $cleartext is unchanged"
else
  echo "Encrypting $cleartext to ${cyphertext}"
  gpg2 -o- -a -r brianddk -e "$cleartext" | dos2unix | sed -e "$script" > "${cyphertext}"
fi
