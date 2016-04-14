[![Version Status](https://img.shields.io/cocoapods/v/CSSystemInfoHelper.svg?style=flat)](http://cocoadocs.org/docsets/CSSystemInfoHelper)  [![Platform](http://img.shields.io/cocoapods/p/CSSystemInfoHelper.svg?style=flat)](http://cocoapods.org/?q=CSSystemInfoHelper) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)](https://opensource.org/licenses/MIT)

# CSSystemInfoHelper

A utility library for getting system info. It’s meant to provide a more straightforward way of accessing information only available through C APIs and to provide shorthands for most common usage scenarios.

## Getting Started

### Installation through CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:

````ruby
use_frameworks!

target 'MyApp' do
  pod 'CSSystemInfoHelper', '~> 1.2'
end
````

### In your Project

```swift
import CSSystemInfoHelper

print("\(CSSystemInfoHelper.sharedHelper().systemInfoString)"
```

## Examples

Please note that you can also see usage examples in the [example app](https://github.com/thecatalinstan/CSSystemInfoHelper/tree/master/CSSystemInfoHelperApp)

### Getting IPv4 interfaces and addresses

```swift
for (ifname, ipaddr) in CSSystemInfoHelper.sharedHelper().AllIPAddresses {
    print("\(ifname): \(ipaddr)")
}
```

### Getting System Info from `uname(3)`

```swift
for (key, value) in CSSystemInfoHelper.sharedHelper().systemInfo {
    print("\(key): \(value)")
}
```

### Getting Human-readable Memory Usage

```swift
print(CSSystemInfoHelper.sharedHelper().memoryUsageString)
```

## What’s Next

Check out the complete documentation on [CocoaDOcs](http://cocoadocs.org/docsets/CSSystemInfoHelper/1.2.0/Classes/CSSystemInfoHelper.html).

