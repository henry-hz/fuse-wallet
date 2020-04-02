Fuse forks and firebase guide
In Order to fork the Fuse wallet and connect it successfully to the fuse servers you will need to do several things.

Fork the Fuse wallet repo:
https://github.com/fuseio/fuse-wallet
Change the bundle id:
Search all for “io.fuse.fusecash” and replace it with you unique bundle id.
Create a firebase account:
https://firebase.google.com/
Create firebase mobile apps (android and ios) and add the google services files to your fork:
Ios (steps 1-3): https://firebase.google.com/docs/ios/setup
Android (Option 1, steps 1-3): https://firebase.google.com/docs/android/setup
Add phone authentication to your firebase project:
Step 1 only: https://firebase.google.com/docs/auth/android/phone-auth
Create production signing keys:
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
Add your keys to the project:
Create a key.properties file in the android directory with the following properties:
storePassword=PASSWORD
keyPassword=PASSWORD
keyAlias=alias_name
storeFile=my-release-key.keystore
Add firebase your debug and production keys sha1:
https://stackoverflow.com/questions/39144629/how-to-add-sha-1-to-android-application
Send us your bundle id and admin keys:
To generate a private key file for your service account:
In the Firebase console, open Settings > Service Accounts.
Click Generate New Private Key, then confirm by clicking Generate Key.

