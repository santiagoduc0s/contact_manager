# Contact+

Contact+ it's a simple app to manage you contacts in android and ios.

The idea of this repo is make a guide of how to upload an app to the stores.

You can find the apps in the next links:
* [App Store](https://apps.apple.com/gb/app/contact/id6737725485?platform=iphone)
* [Play Store](https://play.google.com/apps/testing/com.ducos.contactsmanager) (I need 20 testers to upload to production)


# Steps to uploads to the App Store and Play Store

The next steps explain the minimal things (developing part) to upload an app to the stores

## Generate Icon

```
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

## Bundle id and namespace

```
dart run change_app_package_name:main com.ducos.contactsmanager
```

## Config display name

* In android go to ```android/app/src/main/AndroidManifest.xml```
* And update the field ```android:label="Contact+"```
----
* In ios go to ```ios/Runner/Info.plist```
* And update the key ```CFBundleDisplayName```

## Config native splash screen

```
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```

## Make builds

### iOS
```
flutter build ios --release
```

### Android
```
flutter build appbundle
```
