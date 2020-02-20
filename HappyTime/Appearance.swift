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
    
    var happyTime: Int = 0
    
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

extension Int {
    func toDuration() -> String {
        if self <= 0 { return "00:00" }

        let time = calculatorDuration()
        let hours = time.0
        let mins = time.1
        let seconds = time.2

        var str = ""
        if hours > 0 {
            str = String(format: "%02d:%02d:%02d", hours, mins, seconds)
        } else {
            str = String(format: "%02d:%02d", mins, seconds)
        }
        return str
    }
    
    private func calculatorDuration() -> (Int, Int, Int) {
       var durationValue = Int64(self)

       let hours = (durationValue >= 3600) ? (durationValue / 3600) : 0
       durationValue = durationValue % 3600
       let mins = (durationValue >= 60) ? (durationValue / 60) : 0
       durationValue = durationValue % 60
       let seconds = (durationValue > 0) ? durationValue : 0

       return (Int(hours), Int(mins), Int(seconds))
    }
}

