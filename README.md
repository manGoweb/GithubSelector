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

## Test app

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

## Dependencies

* [Presentables](https://github.com/manGoweb/Presentables)
* [SnapKit](https://github.com/SnapKit/SnapKit)


## Author

Ondrej Rafaj, dev@mangoweb.cz

## License

GithubSelector is available under the MIT license. See the LICENSE file for more info.
