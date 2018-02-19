//
//  RestResponse.swift
//  USAStatesInfo
//
//  Created by Ramesh_Venteddu on 1/30/18.
//  Copyright © 2018 valador. All rights reserved.
//

import Foundation

struct RestResponse: Decodable {
    var messages:[String]?
    var result:[State]?
}
