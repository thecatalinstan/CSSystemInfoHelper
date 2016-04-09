[![Version Status](https://img.shields.io/cocoapods/v/CRSystemInfoHelper.svg?style=flat)](http://cocoadocs.org/docsets/CRSystemInfoHelper)  [![Platform](http://img.shields.io/cocoapods/p/CRSystemInfoHelper.svg?style=flat)](http://cocoapods.org/?q=CRSystemInfoHelper) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
 [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)](https://opensource.org/licenses/MIT)
 
# CRSystemInfoHelper

A utility library for getting system info. It’s meant to provide a more straightforward way of accessing information only available through C APIs and to provide shorthands for most common usage scenarios.

## Install through CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:

````ruby
use_frameworks!
pod ‘CRSystemInfoHelper’  
````

## Getting Started

### Installation through CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your Podfile:

````ruby
use_frameworks!
pod ‘CRSystemInfoHelper’  
````

### In your Project

```swift
import CRSystemInfoHelper

print("\(CRSystemInfoHelper.sharedHelper().systemInfoString)"
```

## Examples

Please note that you can also see usage examples in the [example app](https://github.com/thecatalinstan/CRSystemInfoHelper/tree/master/CRSystemInfoHelperApp)

### Getting IPv4 interfaces and addresses

```swift
for (ifname, ipaddr) in CRSystemInfoHelper.sharedHelper().AllIPAddresses {
    print("\(ifname): \(ipaddr)")
}
```

### Getting System Info from `uname(3)`

```swift
for (key, value) in CRSystemInfoHelper.sharedHelper().systemInfo {
    print("\(key): \(value)")
}
```

### Getting Human-readable Memory Usage

```swift
print(CRSystemInfoHelper.sharedHelper().memoryUsageString)
```

