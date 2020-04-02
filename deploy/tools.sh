#!/bin/bash
# Country Name (2 letter code) [AU]:GB
# State or Province Name (full name) [Some-State]:London
# Locality Name (eg, city) []:
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Total Onion Ltd
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:Total Onion Enterprise
# Email Address []:

# --------------------- ANDROID -----------------------

# --- PRODUCTION KEYSTORE
# manually defined paramenters 

export PROD_KEYSTORE_NAME=release.keystore
export DEBUG_KEYSTORE_NAME=debug.keystore
export PROD_ALIAS=android_alias
export DEBUG_ALIAS=android_alias
export PROD_KEYSTORE_PATH=./release.keystore
export DEBUG_KEYSTORE_PATH=./$DEBUG_KEYSTORE_NAME


# --- CREATE PROD KEYS
function create_prod_signing_keys() {
  keytool -genkey -v -keystore $PROD_KEYSTORE_NAME -alias $PROD_ALIAS -keyalg RSA -keysize 2048 -validity 10000
}

# --- CREATE DEBUG KEYS
function create_debug_signing_keys() {
  keytool -genkey -v -keystore $DEBUG_KEYSTORE_NAME -storepass android -alias $DEBUG_ALIAS -keypass android -keyalg RSA -keysize 2048 -validity 10000
}

# --- RELEASE FINGERPRINT
# add this fingerprint to the:
# https://console.firebase.google.com/u/0/project/wepy-wallet/settings/general/android:io.wepy.wallet
function get_release_fingerprint() {
  keytool -list -v -alias $PROD_ALIAS -keystore $PROD_KEYSTORE_PATH
  # keytool -exportcert -v -alias $PROD_ALIAS -keystore $PROD_KEYSTORE_PATH
}

# --- DEBUG FINGERPRINT
function get_debug_fingerprint() {
  keytool -list -v -alias $DEBUG_ALIAS -keystore $DEBUG_KEYSTORE_PATH 
}

# --- JKS CONVERSION
# convert JKS key to PKCS12 [public key cryptography standard] 
# we don't use this function, it's here only to teach
function convert_jks_to_pkcs12() {
  keytool -importkeystore -srckeystore release.keystore -destkeystore release.keystore -deststoretype pkcs12
}

# --- DEBUG KEYSTORE
# debug fingerprint has pre-defined alias, path and passwords
function get_debug_fingerprint() {
  keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android 
}

# --- KEY PROPERTIES
# create a file names key.properties and add the text below the <<EOF line
# change the storePassword and keyPassword to your passwords
# move this file to the android root (see build.gradle line 61 and follow there)
# https://developer.android.com/studio/publish/app-signing
function create_key_properties() {
cat <<EOF >key.properties
storePassword=PASSWORD
keyPassword=PASSWORD
keyAlias=$PROD_ALIAS
storeFile=$PROD_KEYSTORE_NAME
EOF
}


# --------------------- IOS --------------------------
# Generate a certificate signing request
function generate_certificate() {
  openssl req -nodes -newkey rsa:2048 -keyout ios.key -out CertificateSigningRequest.certSigningRequest
}

# - Login to developer.apple.com, go to:
# - "Member Center" -> "Manage your certificates, App IDs, devices, and provisioning profiles." -> "Certificates" -> "Add"

# - Go through the wizard, selecting the certificate type, and uploading the .csr.
# - Download the .cer file, saving it to the folder created in step 1

# Convert the .cer file to a .pem file:
function convert_cer() {
  openssl x509 -in ios.cer -inform DER -out ios.pem -outform PEM
}

# Convert the .pem to a .p12:
# https://codemagic.io/app/5e4ea259b0845167ee42217f/workflow/5e4ea259b0845167ee42217e/settings
function convert_pem() {
  openssl pkcs12 -export -inkey ios.key -in ios.pem -out ios.p12
}

# You can now create a "Provisioning Profile" in the "Member Center" on developer.apple.com using the certificate you made in step 4


