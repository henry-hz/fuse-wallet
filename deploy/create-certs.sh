#!/bin/bash
# Country Name (2 letter code) [AU]:GB
# State or Province Name (full name) [Some-State]:London
# Locality Name (eg, city) []:
# Organization Name (eg, company) [Internet Widgits Pty Ltd]:Total Onion Ltd
# Organizational Unit Name (eg, section) []:
# Common Name (e.g. server FQDN or YOUR name) []:Total Onion Enterprise
# Email Address []:


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


