# Flutter flavors

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
  <li><a href="#about-project">About the project</a></li>
    <li>
      <a href="#android-setup">Android setup</a>
      <ul>
        <li><a href="#gradle-setup">Gradle setup</a></li>
        <li><a href="#android-icon">Android application icon</a></li>
      </ul>
    </li>
    <li>
      <a href="#ios-setup">iOS setup</a>
      <ul>
        <li><a href="#prerequisites">New and edit schemes</a></li>
        <li><a href="#installation">Bundle id and app name</a></li>
        <li><a href="#installation">iOS application icon</a></li>
      </ul>
    </li>
    <li><a href="#firebase-setup">Firebase setup</a>
    <ul>
        <li><a href="#prerequisites">Android</a></li>
        <li><a href="#installation">iOS</a></li>
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
 (https://dd47327b-1823-4d83-b642-c64124bc5bd0.mock.pstmn.io/dev/flavor)

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

### Android application icon

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

You can setup entry point in Android Studio and VSCode

- Create 2 files `main_dev.dart` and `main_staging.dart` with the same contents as `main.dart`
## Firebase setup

