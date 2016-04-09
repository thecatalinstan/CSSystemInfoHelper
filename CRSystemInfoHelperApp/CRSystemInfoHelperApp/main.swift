//
//  main.swift
//  CRSystemInfoHelperApp
//
//  Created by Cătălin Stan on 09/04/16.
//  Copyright © 2016 Cătălin Stan. All rights reserved.
//

import Foundation
import CRSystemInfoHelper

let helper:CRSystemInfoHelper = CRSystemInfoHelper.sharedHelper()

// IPv4 Addresses
print("IPv4 Interfaces")
for (ifname, ipaddr) in helper.AllIPAddresses {
    print("\t\(ifname): \(ipaddr)")
}
print()

// Main interface
print("Main IP: \(helper.IPAddress)")
print()

// System info
print("System Info (uname):")
for (key, value) in helper.systemInfo {
    print("\t\(key): \(value)")
}
print()

// System Info String
print("System Info String:")
print(helper.systemInfoString)
print()

// System Version String
print("System Version String:")
print(helper.systemVersionString)
print()

// Memory Usage
print("Memory Usage: \(helper.memoryUsage)")
print()

// Memory Usage String
print("Memory Usage String: \(helper.memoryUsageString)")
print()
