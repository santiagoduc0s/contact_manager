# Contact+

Contact+ it's a simple app to manage you contacts in android and ios.

## Generate Icon

```
dart run flutter_launcher_icons -f flutter_launcher_icons.yaml
```

## Bundle id and namespace

```
dart run change_app_package_name:main com.ducos.contactsmanager
```

## Config display 

* In android go to ```android/app/src/main/AndroidManifest.xml```
* And update the field ```android:label="Contact+"```
----
* In ios go to ```ios/Runner/Info.plist```
* And update the key ```CFBundleDisplayName```

## Config native splash screen

```
dart run flutter_native_splash:create --path=flutter_native_splash.yaml
```