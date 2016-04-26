# Change Log

This file includes all notable changes to CSSystemInfoHelper.

`CSSystemInfoHelper` uses [Semantic Versioning](http://semver.org/).

---

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
