//
//  AppDelegate.swift
//  HappyTime
//
//  Created by Wade Zhao on 8/26/19.
//  Copyright © 2019 Wade Zhao. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
	
	func applicationDidFinishLaunching(_ aNotification: Notification) {
        Appearance.shared.setup()
	}

	func applicationWillTerminate(_ aNotification: Notification) {}
}

