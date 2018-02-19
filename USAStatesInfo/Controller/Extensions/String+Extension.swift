//
//  String+Extension.swift
//  USAStatesInfo
//
//  Created by Ramesh Venteddu on 1/31/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

extension String{
    mutating func kmToMile(){
        let str = self
        let kmStr = str.components(separatedBy: "SKM")[0]
        let km:Double = Double(kmStr)!
        let mile = km * 0.3861022
        self = String(format: "%.2fMLS", mile)
    }
}
