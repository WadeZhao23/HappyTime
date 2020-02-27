//
//  NS+Extension.swift
//  HappyTime
//
//  Created by Wade Zhao on 2/27/20.
//  Copyright © 2020 Wade Zhao. All rights reserved.
//

import Cocoa

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

