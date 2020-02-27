//
//  DataCenter.swift
//  HappyTime
//
//  Created by Wade Zhao on 2/27/20.
//  Copyright © 2020 Wade Zhao. All rights reserved.
//

import Cocoa

class DataCenter: NSObject {
    static let shared = DataCenter()
    
    let focusTimeLists: [String] = ["15", "20", "30", "40", "45", "50", "60"]
    let happyTimeLists: [String] = ["1", "2", "3", "5", "10", "15", "20", "25", "30"]
    
    var happyTime: Int = 0
    var focusTime: Int = 0
}
