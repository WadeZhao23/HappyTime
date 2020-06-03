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
    
    lazy var happyTimeWindowController: HappyTimeWindowController = {
        if let v = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "HappyTimeWindowController") as? HappyTimeWindowController {
            return v
        }
        return HappyTimeWindowController()
    }()
    
    func setup() {
        setupItem()
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
    
    private func setupPopover() {
        guard let vc = NSStoryboard(name: "Main", bundle: nil).instantiateController(withIdentifier: "MainViewController") as? MainViewController else {
            fatalError("can't get the main viewcontroller")
        }
        
        popover.contentViewController = vc
        popover.delegate = self
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

extension Appearance: NSPopoverDelegate {
    func popoverShouldClose(_ popover: NSPopover) -> Bool {
        return true
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


