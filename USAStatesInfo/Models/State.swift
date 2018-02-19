//
//  State.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

struct State: Decodable {
    var id:Int?
    var country:String?
    var name:String?
    var abbr:String?
    var area:String?
    var largest_city:String?
    var capital:String?
}
