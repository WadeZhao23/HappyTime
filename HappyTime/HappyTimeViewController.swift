//
//  HappTimeViewController.swift
//  HappyTime
//
//  Created by Wade Zhao on 1/8/20.
//  Copyright © 2020 Wade Zhao. All rights reserved.
//

import Cocoa

class HappyTimeViewController: NSViewController {
    @IBOutlet weak var countDownLabel: NSTextField!
    @IBOutlet weak var endButton: NSButton!
    
    var timer: Timer?
    var happyTime: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubViews()
        setupTimer()
    }
}

extension HappyTimeViewController {
    private func setupBackground() {
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.gray.withAlphaComponent(0.6).cgColor
    }
    
    private func setupSubViews() {
        endButton.target = self
        endButton.action = #selector(tapEndButton)
        updateTimeLabel(Appearance.shared.happyTime)
        setupBackground()
    }
    
    @objc func tapEndButton() {
        Appearance.shared.happyTimeWindowController.close()
    }
    
    @objc func updateTimeLabel(_ time: Int) {
        countDownLabel.stringValue = time.toDuration()
    }
    
    func setupTimer() {
        timer = Timer(timeInterval: 1, repeats: true, block: { [weak self] (temp) in
            Appearance.shared.happyTime = Appearance.shared.happyTime - 1
            self?.updateTimeLabel(Appearance.shared.happyTime)
        })
        RunLoop.current.add(timer!, forMode: .default)
        timer?.fire()
    }
}
