//
//  ViewController.swift
//  HappyTime
//
//  Created by Wade Zhao on 8/26/19.
//  Copyright © 2019 Wade Zhao. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    @IBOutlet weak var countDownLabel: NSTextField!
    @IBOutlet weak var durationComboBox: NSComboBox!
    @IBOutlet weak var happyTimeComboBox: NSComboBox!
    @IBOutlet weak var startButton: NSButton!
    
    let durationDatas: [String] = ["15", "20", "30", "40", "45", "50", "60"]
    let happyTimeDatas: [String] = ["1", "2", "3", "5", "10", "15", "20", "25", "30"]
    
    let durationIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "duration")
    let happyTimeIdentifier: NSUserInterfaceItemIdentifier = NSUserInterfaceItemIdentifier(rawValue: "happyTime")
    
    var countDownTimer: Timer?
    var certainFocusTime: Int = 0
    
    override func viewDidLoad() {
		super.viewDidLoad()
        setupSubViews()
	}

	override var representedObject: Any? {
		didSet {
		}
	}
}

extension MainViewController {
    func setupSubViews() {
        countDownLabel.stringValue = "00:00"
        
        durationComboBox.addItems(withObjectValues: durationDatas)
        happyTimeComboBox.addItems(withObjectValues: happyTimeDatas)
        
        durationComboBox.identifier = durationIdentifier
        happyTimeComboBox.identifier = happyTimeIdentifier
        
        startButton.target = self
        startButton.action = #selector(tapStartAction)
    }
    
    @objc func tapStartAction() {
        let durationTime: Int = Int(durationDatas[durationComboBox.indexOfSelectedItem]) ?? 0
        let focusTime: Int = Int(happyTimeDatas[happyTimeComboBox.indexOfSelectedItem]) ?? 0

        Timer.scheduledTimer(withTimeInterval: TimeInterval(durationTime * 60), repeats: false) { [weak self] (timer) in
            Appearance.shared.happyTimeWindowController.showWindow(nil)
            self?.countDownTimer?.invalidate()
            self?.countDownLabel.stringValue = "00:00"
        }
        Appearance.shared.closePopover()
        Appearance.shared.happyTime = focusTime * 60
        certainFocusTime = durationTime * 60
        setupCountDownTimer()
    }
    
    private func setupCountDownTimer() {
        countDownTimer = Timer(timeInterval: 1, repeats: true, block: { [weak self] (temp) in
            self?.certainFocusTime = (self?.certainFocusTime ?? 0) - 1
            self?.countDownLabel.stringValue = self?.certainFocusTime.toDuration() ?? "00:00"
        })
        RunLoop.current.add(countDownTimer!, forMode: .default)
        countDownTimer?.fire()
    }
}
