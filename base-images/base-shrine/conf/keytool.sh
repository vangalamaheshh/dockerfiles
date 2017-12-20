#!/bin/sh

#The cryptographic keystore file used by Shrine.
KEYSTORE_FILE=shrine.keystore

#Default password for the keystore
KEYSTORE_PASSWORD="sslpass"

#Human-readable name for the cryptographic certificate generated for this Shrine node.
KEYSTORE_ALIAS="localhost"

#Human-readable name for the cryptographic certificate generated for this Shrine node.
KEYSTORE_HUMAN="Docker Cert for ${KEYSTORE_ALIAS}"

#City where the node resides; will be included in generated cryptographic certificate.
KEYSTORE_CITY="Worcester"

#State where the node resides; will be included in generated cryptographic certificate.
KEYSTORE_STATE="MA"

#Country where the node resides; will be included in generated cryptographic certificate.
KEYSTORE_COUNTRY="US"

#Specify Host IP Address
CN="127.0.0.1"
#Name Docker Hostnames so certificate can be shared by multiple containers
SAN="IP:127.0.0.1,DNS:localhost"

# Generate the Server Key

${JAVA_HOME}/bin/keytool -genkeypair -keysize 2048 -alias $KEYSTORE_ALIAS -dname "CN=$CN, OU=$KEYSTORE_HUMAN, O=SHRINE Network, L=$KEYSTORE_CITY, S=$KEYSTORE_STATE, C=$KEYSTORE_COUNTRY" -ext "SAN=$SAN" -keyalg RSA -keypass $KEYSTORE_PASSWORD -storepass $KEYSTORE_PASSWORD -keystore $KEYSTORE_FILE -validity 7300

# Verify that the key was stored

${JAVA_HOME}/bin/keytool -list -v -keystore $KEYSTORE_FILE -storepass $KEYSTORE_PASSWORD

# Export key to a Self-Signed Certificate

${JAVA_HOME}/bin/keytool -export -alias $KEYSTORE_ALIAS -storepass $KEYSTORE_PASSWORD -file $KEYSTORE_ALIAS.cer -keystore $KEYSTORE_FILE

cp shrine.keystore /opt/shrine/shrine.keystore

exit;
