# Flutter flavors

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
  <li><a href="#about-project">About the project</a></li>
    <li>
      <a href="#android-setup">Android setup</a>
      <ul>
        <li><a href="#android-setup-gradle">Gradle setup</a></li>
      </ul>
    </li>
    <li>
      <a href="#ios-setup">iOS setup</a>
      <ul>
        <li><a href="#ios-setup-schemes">New and edit schemes</a></li>
        <li><a href="#ios-setup-app">Bundle id and app name</a></li>
      </ul>
    </li>
    <li>
      <a href="#app-icon">App icon</a>
      <ul>
        <li><a href="#android-app-icon">Android</a></li>
        <li><a href="#ios-app-icon">iOS</a></li>
      </ul>
    </li>
    <li><a href="#firebase-setup">Firebase setup</a>
    <ul>
        <li><a href="#firebase-setup-android">Android</a></li>
        <li><a href="#firebase-setup-ios">iOS</a></li>
      </ul>
    </li>
    <li><a href="#summary">Summary</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About the project

In a Flutter project, you usually develop against separate environments, such as development and production. Each environment can have its own endpoint, API, configuration, Firebase, ... and even separate visual identities if you want to clearly differentiate them.

Flutter Flavors make it possible to run different versions of your app on the same device. At the same time, they keep those environments isolated from one another.

In this project, we separate 2 environments: dev and staging.
I'm already mock a Postman server to demo multi endpoint API.
 (https://f43ea7f6-d185-4998-8f94-01f2a9f954f0.mock.pstmn.io/dev/flavor and https://f43ea7f6-d185-4998-8f94-01f2a9f954f0.mock.pstmn.io/staging/flavor)

 ![Home page](/attachment/home.png)

 For each environment, the home page will look something like this, name of environment in the center, and two button to test Firebase Crashlytics below.


## Android setup

### Gradle setup

Open [build.gradle](/android/app/build.gradle) inside `/android/app/build.gradle` and insert the code below:

``` gradle
android {
    ...

    defaultConfig {
        ...
        applicationId "vn.flavors.flutter_flavors_manual"
        ...
    }

    flavorDimensions "flavor-config"

    productFlavors {
        dev {
            dimension "flavor-config"
            resValue "string", "app_name", "Flavors-Dev"
            applicationIdSuffix ".dev"
            versionNameSuffix ".dev"
        }
        staging {
            dimension "flavor-config"
            resValue "string", "app_name", "Flavors-Staging"
            applicationIdSuffix ".staging"
            versionNameSuffix ".staging"
        }
    }
}
```

If you want to change the application name, go to the AndroidManifest `android/app/src/main/AndroidManifest.xml`
Change the `android:label` to res you defined inside `build.gradle`: 
```xml
android:label="@string/app_name"
```
![Home page](/attachment/android_manifest.png)



In this code:
 - We declare a new flavor dimension called `flavor-config`, you can declare multi flavor dimension , [see details](https://developer.android.com/studio/build/build-variants#flavor-dimensions)
 - Then you specify all the product flavors and override certain properties for each value of the `flavor-config` dimension.
 - Not only `applicationIdSuffix`, string resource `app_name`,... but also you can override `versionNameSuffix`,`versionCode`, `minSdkVersion`, `targetSdkVersion`, etc...


## iOS setup

- Open project's iOS module in Xcode
![Home page](/attachment/open_xcode.png)

- Create new scheme `dev` and `staging` target to `Runner`
- Remove old scheme `Runner`
![Home page](/attachment/manage_scheme.gif)

- Go to the `Configuration` in `project Runner`
![Home page](/attachment/project_runner.png)

- For each environment, create 3 `configuration files` Debug, Profile and Release like this: 

![Home page](/attachment/configurations.png)

- For `each schemes`, edit the `build configuration` point to `configurations file` which you just created :

![Home page](/attachment/edit_scheme.gif)

- Change the `bunndle id` for each env:

Go to `Target Runner`, search `identifier`, it will show the `Product Bundle Identifier`, you can configure `bundle id` here

![Home page](/attachment/bundle_id.png)

- Change the `app name`:

- Add a `User-Define setting`:
![Home page](/attachment/define_setting.png)

- Named it and each environment
![Home page](/attachment/app_display_name.png)

- Set `APP_DISPLAY_NAME` to `Bundle display name` in `Info.plist`
![Home page](/attachment/info_plist.png)

## Run application
You can run or build application by Terminal with flag `--flavor dev` or `--flavor staging`

Ex: 
```cmd
flutter build apk --flavor dev
```
## Entry point
To speed up run project, and configure advanced setting in runtime such as api endpoint, ...

You can setup entry point in Android Studio and VSCode. I will show only for Android Studio, for VSCode you can setup in `launch.json`

- Create 2 files `main_dev.dart` and `main_staging.dart` with the same contents as `main.dart`.
- Edit Configurations in Android Studio

![Home page](/attachment/edit_configurations.png)

- Add new Configurations

![Home page](/attachment/edit_configurations_1.png)

- Edit `Name`, `Dart Entrypoint`, `Build Flavor` and check `Store as Project file`

![Home page](/attachment/edit_configurations_2.png)

## App icon
You can customize the icon by manually or automatically. In this case I am using [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) to generate application icons for this project.
The config file is called `flutter_launcher_icons-<flavor>.yaml` by replacing `<flavor> `by the name of your desired flavor.

So, we will create 2 files `flutter_launcher_icons-dev.yaml` and `flutter_launcher_icons-staging.yaml` in the project directory.

```yaml
flutter_icons:
  android: true
  ios: true
  image_path_ios: "assets/launchers/icon_launcher_ios.png"
  remove_alpha_ios: true
```

`Assets`

![Home page](/attachment/launchers.png)

And run the following command

```cmd
flutter pub run flutter_launcher_icons:main -f flutter_launcher_icons*
```

### Android


![Home page](/attachment/android_launchers.png)



### iOS

![Home page](/attachment/ios_launchers.png)




## Firebase setup

You can create a Firebase project for each environment (alias F1) or create only one Firebase project and add an flavor app to that (alias F2). This structure will take affect to android setup.

![Home page](/attachment/firebase_structure_1.png)
![Home page](/attachment/firebase_structure_2.png)

Next, we use FlutterFire CLI to initialize Firebase setup.

```cmd
flutterfire config \
  --project=flavors-ex \
  --out=lib/firebase_options_dev.dart \
  --android-package-name=vn.flavors.flutter_flavors_manual.dev \
  --ios-bundle-id=vn.flavors.flutterFlavorsManual.dev
```

Details:
- --project: Firebase project id you want to connect.
- --out: name and path of fire generated.
- --android-package-name: android package name with suffix
- --ios-bundle-id: iOS bundle id with suffix

If you use F1, you will need to change the project id in command line compatible with your flavor project. On other hand, you keep the project id not changed for each flavor.

FlutterFire will generate 4 files : 
 - `lib/firebase_options_dev.dart`: do not modify by hand
 - `android/app/google-services.json`: no need to do anymore if used F2, or copy this file to `android/app/src/<environment>` if used F1.

![Home page](/attachment/firebase_android_config.png)


 - `ios/firebase_app_id_file.json`: copy this to a new directory
 - `ios/Runner/GoogleService-Info.plist`: copy this to a new directory

![Home page](/attachment/firebase_ios_config.png)

Run the command for Staging environment, i am using F2:

```cmd
flutterfire config \
  --project=flavors-ex \
  --out=lib/firebase_options_staging.dart \
  --android-package-name=vn.flavors.flutter_flavors_manual.staging \
  --ios-bundle-id=vn.flavors.flutterFlavorsManual.staging
```
Copy `android/app/google-services.json` if using F1.
Copy `ios/firebase_app_id_file.json` to above directory, and download `GoogleService-Info.plist` from Firebase Console.

![Home page](/attachment/firebase_ios_config_2.png)

### Android firebase setup

Android setup done.

### iOS firebase setup

`GoogleService-Info.plist` and `firebase_app_id_file.json` contain only one app info, so you must copy `GoogleService-Info.plist` and `firebase_app_id_file.json` for `dev` if you run `flavor dev`.

So use `Build Phases` in Xcode to copy file to correct location

Copy above directory contain `ios/Runner/GoogleService-Info.plist` and `ios/firebase_app_id_file.json` to `Runner`

![Home page](/attachment/firebase_ios_config_3.png)

![Home page](/attachment/firebase_ios_config_4.png)

Add new `Build Phase` and bring it follow `Link Binary With Libraries`

![Home page](/attachment/firebase_ios_config_5.png)

![Home page](/attachment/firebase_ios_config_6.png)


```shell
# Type a script or drag a script file from your workspace to insert its path.
environment="default"

# Regex to extract the scheme name from the Build Configuration
# We have named our Build Configurations as Debug-dev, Debug-prod etc.
# Here, dev and prod are the scheme names. This kind of naming is required by Flutter for flavors to work.
# We are using the $CONFIGURATION variable available in the XCode build environment to extract 
# the environment (or flavor)
# For eg.
# If CONFIGURATION="Debug-prod", then environment will get set to "prod".
if [[ $CONFIGURATION =~ -([^-]*)$ ]]; then
environment=${BASH_REMATCH[1]}
fi

echo $environment

# Name and path of the resource we're copying
GOOGLESERVICE_INFO_PLIST=GoogleService-Info.plist
GOOGLESERVICE_INFO_FILE=${PROJECT_DIR}/Config/${environment}/${GOOGLESERVICE_INFO_PLIST}

FIREBASE_APP_ID_JSON=firebase_app_id_file.json
FIREBASE_APP_ID_FILE=${PROJECT_DIR}/Config/${environment}/${FIREBASE_APP_ID_JSON}

# Make sure GoogleService-Info.plist exists
echo "Looking for ${GOOGLESERVICE_INFO_PLIST} in ${GOOGLESERVICE_INFO_FILE}"
if [ ! -f $GOOGLESERVICE_INFO_FILE ]
then
echo "No GoogleService-Info.plist found. Please ensure it's in the proper directory."
exit 1
fi

# Make sure firebase_app_id_file.json exists
echo "Looking for ${FIREBASE_APP_ID_JSON} in ${FIREBASE_APP_ID_FILE}"
if [ ! -f $FIREBASE_APP_ID_FILE ]
then
echo "No firebase_app_id_file.json found. Please ensure it's in the proper directory."
exit 1
fi

# Get a reference to the destination location for the GoogleService-Info.plist
# This is the default location where Firebase init code expects to find GoogleServices-Info.plist file

PLIST_BUILD_DESTINATION=${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app
echo "Will copy ${GOOGLESERVICE_INFO_PLIST} to final destination: ${PLIST_BUILD_DESTINATION}"

cp "${GOOGLESERVICE_INFO_FILE}" "${PLIST_BUILD_DESTINATION}"

PLIST_DESTINATION=${PROJECT_DIR}/Runner
echo "Will copy ${GOOGLESERVICE_INFO_PLIST} to final destination: ${PLIST_DESTINATION}"

cp "${GOOGLESERVICE_INFO_FILE}" "${PLIST_DESTINATION}"

JSON_DESTINATION=${PROJECT_DIR}
echo "Will copy ${FIREBASE_APP_ID_JSON} to final destination: ${JSON_DESTINATION}"

cp "${FIREBASE_APP_ID_FILE}" "${JSON_DESTINATION}"

```











