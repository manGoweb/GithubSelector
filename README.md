# GithubSelector

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)
[![License](https://img.shields.io/cocoapods/l/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)
[![Platform](https://img.shields.io/cocoapods/p/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)

Ever had the need to browse your github repo from your iOS app, select file and load it? No? Well, me neither ... at least till two hours before my first commit here.

GithubSelector is a file browser that allows you to brows through all your repos using github API V3. You can browse any repo you have access to, private or public, yours or a fork while switching branches or selecting any historic commit you might need.

Once done, file will be downloaded and passed back onto you in closure with all the info and content of your file as plain `Data`.

## Screenshots

<img src="/Screenshots/1-login.png?raw=true" width="210" /> <img src="/Screenshots/3-repos.png?raw=true" width="210" />
<img src="/Screenshots/4-files.png?raw=true" width="210" />
<img src="/Screenshots/5-text.png?raw=true" width="210" />
<img src="/Screenshots/6-image.png?raw=true" width="210" />
<img src="/Screenshots/7-file.png?raw=true" width="210" />
<img src="/Screenshots/8-branches.png?raw=true" width="210" />
<img src="/Screenshots/9-commits.png?raw=true" width="210" />


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

#### Cocoapods

GithubSelector is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "GithubSelector"
```

#### Carthage

GithubSelector is also available through [Carthage](https://github.com/Carthage/Carthage). To install
it, simply add the following line to your Cartfile:
```ruby
github "manGoweb/GithubSelector"
```

## Usage

#### Authentication

Add a new url scheme to your apps `Info.plist`, it may look something like this:
```xml
<key>CFBundleURLTypes</key>
<array>
    <dict>
        <key>CFBundleTypeRole</key>
        <string>Editor</string>
        <key>CFBundleURLIconFile</key>
        <string></string>
        <key>CFBundleURLName</key>
        <string>githubselector1</string>
        <key>CFBundleURLSchemes</key>
        <array>
            <string>githubselector1</string>
        </array>
    </dict>
</array>
```

in your `AppDelegate` you have to put a deeplink handler in order to see incoming authentications:

```Swift
func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
    // Create a new config (we recommend you subclass BaseConfig and initialize it with the right values for reusability)
    let config = BaseConfig()
    config.clientId = "<your client id>"
    config.clientSecret = "<your client secret>"
    
    // Store the oAuth token ... we didn't really want to do this for you ;)
    GithubSelector(configuration: config, url: url).didReceiveAuthToken = { token in
        // Store received oAuth token locally (maybe keychain?)
    }

    return true
}
```

#### Implementation

In your view controller (most likely), create a configuration, handle callback methods and eventually present the selector.

```Swift
let selector = GithubSelector()

// Create a new config
let config = BaseConfig()
config.clientId = "<your client id>"
config.clientSecret = "<your client secret>"

selector.logout = {
    // User requested logout, delete locally stored oAuth token (probably from keychain?)
}

// Get your token if you got any (where did you store it? Hope not user defaults!)
if let token = getYourToken() {
    config.clientToken = token
}

// User has finally decided to select a file
selector.didSelectFile = { file in
    /*
    Access the following on your returned file
    
    public let data: Data
    public let name: String
    public let url: String
    public let mode: String
    public let size: Int
    */
}

// Present your brand new Github file selector to the user
selector.present(inViewController: self, configuration: config)
```

## Running demo app

In order to run our provided test app, please don't forget to provide your github client id and secret in `./Example/GithubSelector/Secrets.plist`. It should look something like this:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
        <key>clientId</key>
        <string>vw5t45t45v45y3tc449b58f3</string>
        <key>clientSecret</key>
        <string>97n8v5t047tn5t7c5tcnt724r24rc2c4r2c48345le</string>
    </dict>
</plist>
```

## Localization

We have intentionaly left out any localizations out of the GithubSelector in order to allow maximum customisation. There are two ways to localise:

#### NSLocalizedString

Simple way to localize GithubSelector is to add the following localization keys into your `Localizable.strins` file.
```C
// General
"gs.general.total" = "Total: %d";
"gs.general.unknown" = "Unknown";
"gs.general.never" = "Never";
"gs.general.loading" = "Loading ...";

// Login
"gs.login.oauth-button" = "Login to github.com";

// Repos
"gs.repos.logout" = "Logout";
"gs.repos.filesize" = "Size: %@";
"gs.repos.last_push.never" = "Never";
"gs.repos.last_push" = "Last push: %@";

// Files
"gs.files.folder" = "Folder";
"gs.files.chmod" = "#%@";
"gs.files.chmod.full" = "chmod: %@"
"gs.files.size" = "Size: %@";
"gs.files.change-branch" = "Branches";
"gs.files.select" = "Select";

// Commits
"gs.commits.commited_on" = "on %@";
```

#### Custom localization

For an absolutely super amazing custom localization, please create a class conforming to a `Localizable` protocol and than assign it to `var localizable: Localizable` on the shared GithubSelector.

## Dependencies

* [Presentables](https://github.com/manGoweb/Presentables)
* [SnapKit](https://github.com/SnapKit/SnapKit)


## Roadmap

* Customisation and introducing your own subclassed controllers
* File preview
* Better icons for files

## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

GithubSelector is available under the MIT license. See the LICENSE file for more info.
