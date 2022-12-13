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

In this code:
 - We declare a new flavor dimension called `flavor-config`, you can declare multi flavor dimension , [see details](https://developer.android.com/studio/build/build-variants#flavor-dimensions)
 - Then you specify all the product flavors and override certain properties for each value of the `flavor-config` dimension.
 - Not only `applicationIdSuffix`, string resource `app_name`,... but also you can override `versionNameSuffix`,`versionCode`, `minSdkVersion`, `targetSdkVersion`, etc...

### Android application icon

## iOS setup

## Firebase setup

