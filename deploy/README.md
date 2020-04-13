Fuse forks and firebase guide
In Order to fork the Fuse wallet and connect it successfully to the fuse servers you will need to do several things.

1. Fork the Fuse wallet repo: https://github.com/fuseio/fuse-wallet
2. Change the bundle id: Search all for “io.fuse.fusecash” and replace it with you unique bundle id.
3. Create a firebase account: https://firebase.google.com/
4. Create firebase mobile apps (android and ios) and add the google services files to your fork:<br>
Ios (steps 1-3): https://firebase.google.com/docs/ios/setup<br>
Android (Option 1, steps 1-3): https://firebase.google.com/docs/android/setup
5 .Add phone authentication to your firebase project:<br>
Step 1 only: https://firebase.google.com/docs/auth/android/phone-auth
6. Create production signing keys:<br>
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
7. Add your keys to the project:

- Create a key.properties file in the android directory with the following properties:

    ```bash
    storePassword=PASSWORD
    keyPassword=PASSWORD
    keyAlias=alias_name
    storeFile=my-release-key.keystore
    ```

8. Add firebase your debug and production keys sha1:<br>
https://stackoverflow.com/questions/39144629/how-to-add-sha-1-to-android-application
9. Send us your bundle id and admin keys:<br>
To generate a private key file for your service account:
- In the Firebase console, open Settings > Service Accounts.
- Click Generate New Private Key, then confirm by clicking Generate Key.
