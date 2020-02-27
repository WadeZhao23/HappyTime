//
//  HappyTimeWindowController.swift
//  HappyTime
//
//  Created by Wade Zhao on 1/13/20.
//  Copyright © 2020 Wade Zhao. All rights reserved.
//

import Cocoa

class HappyTimeWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()
        setupWindow()
    }
    
    private func setupWindow() {
        guard let win = window else { return }
        
        win.styleMask = [.fullSizeContentView]
        win.setFrame(NSRect(x: 0, y: 0, width: NSScreen.main?.frame.width ?? 0, height: NSScreen.main?.frame.height ?? 0), display: true)
        win.backgroundColor = NSColor.clear
        win.level = NSWindow.Level.floating
    }
}
