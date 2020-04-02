#!/bin/bash
# https://firebase.google.com/docs/android/setup#create-firebase-project
# use password as 'android'


# to create the key
keytool -exportcert -list -v -alias androiddebugkey -keystore ~/.android/debug.keystore


# to retrieve the key SHA1
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
