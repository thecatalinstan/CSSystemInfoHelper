[![Version Status](https://img.shields.io/cocoapods/v/CSSystemInfoHelper.svg?style=flat)](http://cocoadocs.org/docsets/CSSystemInfoHelper)  [![Platform](http://img.shields.io/cocoapods/p/CSSystemInfoHelper.svg?style=flat)](http://cocoapods.org/?q=CSSystemInfoHelper) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![MIT License](https://img.shields.io/badge/license-MIT-orange.svg?style=flat)](https://opensource.org/licenses/MIT)

# CSSystemInfoHelper

A utility library for getting system info, meant to provide a safe and straightforward way of accessing system information only available through C APIs.

I’ve used this library when making the [criollo.io](https://criollo.io) website in order to display the system the app is running on and various other projects over the years.

## Getting Started

### Installation using Swift Package Manager

### Swift Package Manager

Add the package to your project's dependencies. If you have a `Package.swift`, it should look similar to this:

```swift
dependencies: [
    .package(name: "CSSystemInfoHelper", url: "https://github.com/thecatalinstan/CSSystemInfoHelper", from: "2.0.0"),
]
```

### Installation through CocoaPods

Install using [CocoaPods](http://cocoapods.org) by adding this line to your `Podfile`:

````ruby
use_frameworks!

target 'MyApp' do
  pod 'CSSystemInfoHelper', '~> 2.0'
end
````

### In your Project

```swift
import CSSystemInfoHelper

print("\(CSSystemInfoHelper.shared.systemInfo.string)"
```

## Examples

### Getting IPv4 interfaces and addresses

```swift
let networkInterfaces = CSSystemInfoHelper.shared.networkInterfaces!
for nif in networkInterfaces {
	print("\(nif.name): \(nif.address) (\(nif.familyName))")
}
```

### Getting System Info from `uname(3)`

```swift
let systemInfo = h.systemInfo!
print(systemInfo.string)
print(systemInfo.versionString)
```

### Getting Human-readable Memory Usage

```swift
print(CSSystemInfoHelper.shared.memoryUsageString)
print(CSSystemInfoHelper.shared.memoryPhysicalFootprintString)
```

### Getting the device UUID (macOS only)

```swift
print(CSSystemInfoHelper.shared.platformUUID)
```

## What’s Next

Check out the complete documentation on [CocoaDocs](http://cocoadocs.org/docsets/CSSystemInfoHelper).

