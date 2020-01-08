//
//  Appearance.swift
//  HappyTime
//
//  Created by Wade Zhao on 12/19/19.
//  Copyright © 2019 Wade Zhao. All rights reserved.
//

import Foundation
import Cocoa

class Appearance: NSObject {
    static let shared: Appearance = Appearance()
    let statusItem = NSStatusBar.system.statusItem(withLength:NSStatusItem.squareLength)
    let popover: NSPopover = NSPopover()
    
    func setup() {
        setupItem()
//        buildMenu()
        setupPopover()
    }
    
    private func setupItem() {
        if let button = statusItem.button {
            if NSApp.appearance?.isDarkMode ?? false {
                button.image = NSImage(imageLiteralResourceName: "alarm")
            } else {
                button.image = NSImage(imageLiteralResourceName: "alarm_dark")
            }
            button.layer?.backgroundColor = NSColor.white.cgColor
            button.target = self
            button.action = #selector(tapItemButtonAction)
        }
    }
    
    private func buildMenu() {
        let menu = NSMenu()
        // add separator in menu : menu.addItem(NSMenuItem.separator())
        menu.addItem(NSMenuItem(title: "Quit", action: #selector(NSApp.terminate(_:)), keyEquivalent: "q"))
        statusItem.menu = menu
    }
    
    private func setupPopover() {
        guard let vc = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("can't get the main viewcontroller")
        }
        
        popover.contentViewController = vc
    }
    
    @objc func tapItemButtonAction() {
        if popover.isShown {
            closePopover()
        } else {
            openPopover()
        }
    }
    
    func openPopover() {
        if let button = statusItem.button {
          popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover() {
        popover.close()
    }
}


extension NSAppearance {
    public var isDarkMode: Bool {
        if #available(macOS 10.14, *) {
            if self.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua {
                return true
            } else {
                return false
            }
        } else {
            return false
        }
    }
}

