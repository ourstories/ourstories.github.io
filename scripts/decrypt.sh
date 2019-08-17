#!/bin/bash
cyphertext=$1
path=$(dirname $cyphertext) || exit
cleartext=$(egrep "Comment: source " $1 | dos2unix |  awk '{print $3}')
echo "Decrypting $cyphertext to ${path}/${cleartext}"
gpg2 -q -o- -d "$cyphertext" | dos2unix > "${path}/${cleartext}"
