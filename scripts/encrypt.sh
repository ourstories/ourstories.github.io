#!/bin/bash
cleartext=$1
path=$(dirname $cleartext) || exit
cyphertext=$(egrep "Comment: target " $1 | dos2unix | awk '{print $3}')
source=$(realpath --relative-to="${path}/$(dirname cyphertext)" "$cleartext")
script="s#^-----BEGIN PGP MESSAGE-----#-----BEGIN PGP MESSAGE-----\nComment: source $source#"
if diff -d > /dev/null <( gpg2 -q -o- -d "${path}/${cyphertext}" ) "$cleartext"
then
  echo "Nothing to encrypt, $cleartext is unchanged"
else
  echo "Encrypting $cleartext to ${path}/${cyphertext}"
  gpg2 -o- -a -r brianddk -e "$cleartext" | dos2unix | sed -e "$script" > "${path}/${cyphertext}"
fi
