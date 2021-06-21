# Change Log

This file includes all notable changes to CSSystemInfoHelper.

`CSSystemInfoHelper` uses [Semantic Versioning](http://semver.org/).

---
## [2.0.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/2.0.0) (06/22/2021)

**Released on Tuesday, June 22, 2021**. This release introduces SPM support, extends and refactors the info interface, removes caching of most information snippets retrieved and improves overall code quality and test coverage.

> ***Important!*** This release breaks API compatibility in a number of ways, so please read the changes below carefully, before upgrading an existing installation, as this may require some refactoring.

### Changed

- Deprecate `AllIPAddresses` and `IPAddress` in favor of a new property named `networkInterfaces` which now returns an array of `CSNetworkInterface` objects. This array now also contains IPv6 interfaces, as well as IPv4. [`898069b`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/898069b)
- The `systemInfo` dictionary has been converted to a class where the previous keys are now instance properties. The `systemInfoString` and `systemVersionString` are now instance properties of the `CSSystemInfo` object, `string` and `versionString` respectively. [`b156e26`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/b156e26)
- The `platformUUID` property is now only available on macOS [`3d9127a`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/3d9127a)

### Added

- Added the `memoryPhysicalFootprint` and `memoryPhysicalFootprintString` properties to `CSSystemInfoHelper`, that extract and format the `phys_footprint` member of the `vm_task_info` struct. [2c6943f`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/2c6943f)

### Closed Issues

- Issue [#1](https://github.com/thecatalinstan/CSSystemInfoHelper/issues/1) is closed as a result of `systemInfo` being computed on demand, instead of cached on the first call.

### Improvements

- Adds Swift Package Manager support. [`1291d76`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/1291d76)
- The project now generates one multi-platform target, instead of multiple platform-specific targets.  [`1e82472`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/1e82472)

## [1.4.2](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.4.2) (03/30/2018)

**Released on Friday, March 30, 2018**.

This is a service release, upgrading to the latest Xcode.

## [1.4.1](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.4.1) (07/01/2016)

**Released on Friday, July 1, 2016**.

Fixes build errors on `watchOS`.

## [1.4.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.4.0) (07/01/2016)

**Released on Friday, July 1, 2016**.

### Added

Added the `platformUUID` property.

## [1.3.1](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.3.1) (04/26/2016)

**Released on Tuesday, April 26, 2016**.

`AllIPAddresses` is pre-initialized inside the class’ `+ initialize` method. 

## [1.3.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.3.0) (04/25/2016)

**Released on Monday, April 25, 2016**.

### Changed
Got rid of the lazy init of the shared helper, because of the speed penalty that `dispatch_once` carries. Read more about [the secrets of `dispatch_once`](https://www.mikeash.com/pyblog/friday-qa-2014-06-06-secrets-of-dispatch_once.html) 

## [1.2.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.2.0) (04/11/2016)

**Released on Monday, April 11, 2016**.

Project was renamed to CSSystemInfoHelper

## [1.1.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.1.0) (04/10/2016)

**Released on Sunday, April 10, 2016**.

Hotfix to correct documentation

## [1.0.2](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.0.2) (04/10/2016)

**Released on Sunday, April 10, 2016**.

Hotfix to correct documentation

## [1.0.1](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.0.1) (04/10/2016)

**Released on Sunday, April 10, 2016**.

Hotfix to correct documentation

## [1.0.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/1.0.0) (04/10/2016)

**Released on Sunday, April 10, 2016**.

First stable release, including all targets.

## [0.2.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/0.2.0) (04/09/2016)

**Released on Saturday, April 9, 2016**.

This release contains the first set of usable functionalities

### New APIs

* Added the`AllIPAddresses` and `IPAddress` methods meant for accessing device network interface IPv4 addresses. [`6cba77a`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/6cba77a5be4ad393479cd1c2cc36c7f71ad2826e).
* Added the`systemInfo`, `systemInfoString` and `systemVersionString` for accessing the `utsname` struct returned by `uname(3)`. [`7e57d57`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/7e57d57b5e4047d5896b389999faece7ac392b80).
* Added the`memoryUsage` and `memoryUsageString` for accessing the `kern_return_t` struct returned by [`task_info`](https://www.gnu.org/software/hurd/gnumach-doc/Task-Information.html) function. [`8d17705`](https://github.com/thecatalinstan/CSSystemInfoHelper/commit/8d1770576ee37f49850c6727a0ec98bf08d7ec2e).

## [0.1.0](https://github.com/thecatalinstan/CSSystemInfoHelper/releases/tag/0.1.0) (04/09/2016)

**Released on Saturday, April 9, 2016**.

The initial release. This is a no-op.
