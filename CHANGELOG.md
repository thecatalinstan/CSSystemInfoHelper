# Change Log

This file includes all notable changes to CRSystemInfoHelper.

`CRSystemInfoHelper` uses [Semantic Versioning](http://semver.org/).

---

## [0.2.0](https://github.com/thecatalinstan/CRSystemInfoHelper/releases/tag/0.2.0) (09/05/2016)

**Released on Saturday, April 9, 2016**.

This release contains the first set of usable functionalities

### New APIs

* Added the`AllIPAddresses` and `IPAddress` methods meant for accessing device network interface IPv4 addresses. [`6cba77a`](https://github.com/thecatalinstan/CRSystemInfoHelper/commit/6cba77a5be4ad393479cd1c2cc36c7f71ad2826e).
* Added the`systemInfo`, `systemInfoString` and `systemVersionString` for accessing the `utsname` struct returned by `uname(3)`. [`7e57d57`](https://github.com/thecatalinstan/CRSystemInfoHelper/commit/7e57d57b5e4047d5896b389999faece7ac392b80).
* Added the`memoryUsage` and `memoryUsageString` for accessing the `kern_return_t` struct returned by [`task_info`](https://www.gnu.org/software/hurd/gnumach-doc/Task-Information.html) function. [`7e57d57`](https://github.com/thecatalinstan/CRSystemInfoHelper/commit/7e57d57b5e4047d5896b389999faece7ac392b80).

## [0.1.0](https://github.com/thecatalinstan/CRSystemInfoHelper/releases/tag/0.1.0) (09/05/2016)

**Released on Saturday, April 9, 2016**.

The initial release. This is a no-op.
