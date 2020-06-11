#!/bin/sh

function encrypt {
  PASSPHRASE=$1
  INPUT=$2
  OUTPUT=$3
  gpg --cipher-algo AES256 --symmetric --output $OUTPUT --batch --yes --passphrase $PASSPHRASE $INPUT
}

ENCRYPT_KEY=$1

if [[ ! -z "$ENCRYPT_KEY" ]]; then
  # Encrypt Release key
  encrypt ${ENCRYPT_KEY} release/app-release.jks release/app-release.gpg 
  # Encrypt Play Store key
  encrypt ${ENCRYPT_KEY} release/play-account.json release/play-account.gpg
  # Encrypt Google Services key
  encrypt ${ENCRYPT_KEY} app/google-services.json release/google-services.gpg
else
  echo "ENCRYPT_KEY is empty"
fi