# GithubSelector

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)
[![License](https://img.shields.io/cocoapods/l/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)
[![Platform](https://img.shields.io/cocoapods/p/GithubSelector.svg?style=flat)](http://cocoapods.org/pods/GithubSelector)

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

```Swift
// Create a new config
let config = BaseConfig()
config.clientId = "<your client id>"
config.clientSecret = "<your client secret>"

// Handle some callbacks ... we didn't really want to do this for you ;)
GithubSelector.shared.didReceiveAuthToken = { token in
    // Store received oAuth token locally (maybe keychain?)
}
GithubSelector.shared.logout = {
    // User requested logout, delete locally stored oAuth token (probably from keychain?)
}

// Get your token if you got any (where did you store it? Hope not user defaults!)
if let token = getYourToken() {
    config.clientToken = token
}

// User has finally decided to select a file
GithubSelector.shared.didSelectFile = { file in
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
GithubSelector.present(inViewController: self, configuration: config)
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
